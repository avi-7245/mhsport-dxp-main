package com.mhdsys.competition.management.resource.commands;

import com.liferay.document.library.kernel.model.DLFolderConstants;
import com.liferay.document.library.kernel.service.DLAppServiceUtil;
import com.liferay.document.library.util.DLURLHelperUtil;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.repository.model.FileEntry;
import com.liferay.portal.kernel.repository.model.Folder;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.competition.management.web.constants.CompetitionManagementWebPortletKeys;
import com.mhdsys.schema.model.PTTeacherApplication;
import com.mhdsys.schema.service.PTTeacherApplicationLocalServiceUtil;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.portlet.PortletException;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.pdmodel.PDPageContentStream;
import org.apache.pdfbox.pdmodel.common.PDRectangle;
import org.apache.pdfbox.pdmodel.font.PDType1Font;
import org.apache.pdfbox.pdmodel.graphics.image.LosslessFactory;
import org.apache.pdfbox.pdmodel.graphics.image.PDImageXObject;
import org.osgi.service.component.annotations.Component;

@Component(immediate = true, property = {
		"javax.portlet.name=" + CompetitionManagementWebPortletKeys.MHDSYS_COMPETITION_INITIATION_LIST_MANAGEMENTWEB,
		"javax.portlet.name="
				+ CompetitionManagementWebPortletKeys.MHDSYS_COMPETITION_PT_TEACHER_REQUEST_LIST_MANAGEMENTWEB,
		"javax.portlet.name=" + CompetitionManagementWebPortletKeys.MHDSYS_COMPETITION_SCHEDULED_LIST_MANAGEMENTWEB,
		"javax.portlet.name=" + CompetitionManagementWebPortletKeys.MHDSYS_UPLOADED_RESULT_LIST_MANAGEMENTWEB,
		"mvc.command.name="
				+ CompetitionManagementWebPortletKeys.DOWNLOAD_ID_CARD_MVC_RESOURCE_COMMAND }, service = MVCResourceCommand.class)
public class DownloadIdCardMVCResourceCommand implements MVCResourceCommand {

	private static final Log LOGGER = LogFactoryUtil.getLog(DownloadIdCardMVCResourceCommand.class);
	private static final long PARENT_FOLDER_ID = DLFolderConstants.DEFAULT_PARENT_FOLDER_ID;
	private static final SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

	@Override
	public boolean serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws PortletException {

		LOGGER.info("Generating PT Teacher ID Card PDF...");

		long competitionInitiationId = ParamUtil.getLong(resourceRequest, "competitionInitiationId");
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);

		try {
			// Fetch PT Teacher application data
			List<PTTeacherApplication> applications = PTTeacherApplicationLocalServiceUtil
					.getByCompetitionInitiationId(competitionInitiationId);

			if (applications == null || applications.isEmpty()) {
				LOGGER.error("No application found for initiationId: " + competitionInitiationId);
				resourceResponse.getWriter().write("No application found for this competition.");
				return false;
			}

			PTTeacherApplication application = applications.get(0);

			// Generate PDF
			ByteArrayOutputStream outputStream = generateIdCardPDF(application, resourceRequest, resourceResponse,
					themeDisplay);

			// Set PDF response
			resourceResponse.setContentType("application/pdf");
			resourceResponse.addProperty("Content-Disposition",
					"attachment; filename=ID_Card_" + application.getApplicationNumber() + ".pdf");

		} catch (Exception e) {
			LOGGER.error("Error generating ID card: ", e);
		}

		return false;
	}

	private ByteArrayOutputStream generateIdCardPDF(PTTeacherApplication application, ResourceRequest resourceRequest,
			ResourceResponse resourceResponse, ThemeDisplay themeDisplay) throws IOException {

		// ID card size
		PDDocument document = new PDDocument();
		PDPage page = new PDPage(new PDRectangle(160, 100)); // 160x100 pixels
		document.addPage(page);
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

		try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
			float pageWidth = page.getMediaBox().getWidth(); // 160
			float pageHeight = page.getMediaBox().getHeight(); // 100
			float centerX = pageWidth / 2; // 80

			// Clean white background
			contentStream.setNonStrokingColor(Color.WHITE);
			contentStream.addRect(0, 0, pageWidth, pageHeight);
			contentStream.fill();

			// Simple thin border
			contentStream.setStrokingColor(new Color(180, 180, 180));
			contentStream.setLineWidth(0.5f);
			contentStream.addRect(2, 2, pageWidth - 4, pageHeight - 4);
			contentStream.stroke();

			// Photo at top center
			float photoWidth = 35;
			float photoHeight = 40;
			float photoX = centerX - (photoWidth / 2);
			float photoY = pageHeight - 15; // Top with margin

			// Create dummy photo
			BufferedImage dummyImage = createDummyPhoto(application.getParticipantName(), 70, 80);
			PDImageXObject pdDummyImage = LosslessFactory.createFromImage(document, dummyImage);

			// Draw photo with border
			contentStream.setStrokingColor(new Color(150, 150, 150));
			contentStream.setLineWidth(0.3f);
			contentStream.addRect(photoX, photoY - photoHeight, photoWidth, photoHeight);
			contentStream.stroke();

			// Draw dummy image
			contentStream.drawImage(pdDummyImage, photoX, photoY - photoHeight, photoWidth, photoHeight);

			// Name below photo (centered)
			float nameY = photoY - photoHeight - 8; // 8px below photo
			contentStream.setNonStrokingColor(Color.BLACK);
			contentStream.setFont(PDType1Font.HELVETICA_BOLD, 10);
			String name = application.getParticipantName();

			// Truncate name if too long
			if (name.length() > 22) {
				name = name.substring(0, 19) + "...";
			}

			float nameWidth = PDType1Font.HELVETICA_BOLD.getStringWidth(name) / 1000 * 10;
			float nameX = centerX - (nameWidth / 2);

			contentStream.beginText();
			contentStream.newLineAtOffset(nameX, nameY);
			contentStream.showText(name);
			contentStream.endText();

			// App No below name (centered)
			float appNoY = nameY - 12;
			contentStream.setFont(PDType1Font.HELVETICA, 8);
			String appNo = "App No: " + application.getApplicationNumber();

			float appNoWidth = PDType1Font.HELVETICA.getStringWidth(appNo) / 1000 * 8;
			float appNoX = centerX - (appNoWidth / 2);

			contentStream.beginText();
			contentStream.newLineAtOffset(appNoX, appNoY);
			contentStream.showText(appNo);
			contentStream.endText();

			// Contact below app no (centered)
			float contactY = appNoY - 10;
			String contact = "Contact: " + application.getContactNo();

			float contactWidth = PDType1Font.HELVETICA.getStringWidth(contact) / 1000 * 8;
			float contactX = centerX - (contactWidth / 2);

			contentStream.beginText();
			contentStream.newLineAtOffset(contactX, contactY);
			contentStream.showText(contact);
			contentStream.endText();

			// Issued date at bottom center
			contentStream.setNonStrokingColor(Color.DARK_GRAY);
			contentStream.setFont(PDType1Font.HELVETICA, 6);
			String issuedDate = "Issued: " + formatter.format(new Date());

			float dateWidth = PDType1Font.HELVETICA.getStringWidth(issuedDate) / 1000 * 6;
			float dateX = centerX - (dateWidth / 2);

			contentStream.beginText();
			contentStream.newLineAtOffset(dateX, 8);
			contentStream.showText(issuedDate);
			contentStream.endText();

			contentStream.close();

			// Save PDF
			document.save(outputStream);

			// Save and upload to Document Library
			byte[] pdfBytes = outputStream.toByteArray();
			String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			String fileName = "ID_Card_" + application.getApplicationNumber() + "_" + timestamp + ".pdf";

			File tempFile = File.createTempFile("id_card_", ".pdf");
			try (FileOutputStream fos = new FileOutputStream(tempFile)) {
				fos.write(pdfBytes);
			}

			long fileEntryId = fileUpload(tempFile, fileName, themeDisplay.getScopeGroupId());
			FileEntry fileEntry = DLAppServiceUtil.getFileEntry(fileEntryId);
			String downloadURL = DLURLHelperUtil.getPreviewURL(fileEntry, fileEntry.getFileVersion(), themeDisplay, "");

			LOGGER.info("ID Card Download URL : " + downloadURL);

			JSONObject responseJson = JSONFactoryUtil.createJSONObject();
			responseJson.put("downloadURL", downloadURL);

			resourceResponse.setContentType("application/json");
			PrintWriter outPrint = resourceResponse.getWriter();
			outPrint.print(responseJson.toString());
			outPrint.flush();
			outPrint.close();

			tempFile.deleteOnExit();

		} catch (Exception e) {
			LOGGER.error("Error while generating ID card PDF", e);
		} finally {
			document.close();
		}

		return outputStream;
	}

	// Method to create a dummy photo with user initials
	private BufferedImage createDummyPhoto(String userName, int width, int height) {

		BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
		Graphics2D g2d = image.createGraphics();

		// Light blue background
		g2d.setColor(new Color(230, 240, 255));
		g2d.fillRect(0, 0, width, height);

		// Draw border
		g2d.setColor(new Color(120, 120, 120));
		g2d.drawRect(0, 0, width - 1, height - 1);

		// Extract initials
		String[] nameParts = userName.split(" ");
		StringBuilder initials = new StringBuilder();
		for (String part : nameParts) {
			if (!part.isEmpty()) {
				initials.append(part.charAt(0));
			}
		}
		if (initials.length() > 2) {
			initials = new StringBuilder(initials.substring(0, 2));
		}

		// Draw initials in center
		g2d.setColor(new Color(40, 40, 40));
		g2d.setFont(new Font("Arial", Font.BOLD, 24));

		String initStr = initials.toString().toUpperCase();
		int stringWidth = g2d.getFontMetrics().stringWidth(initStr);
		int stringHeight = g2d.getFontMetrics().getHeight();

		int x = (width - stringWidth) / 2;
		int y = (height + stringHeight) / 2 - 5;

		g2d.drawString(initStr, x, y);

		g2d.dispose();
		return image;
	}

	public Long getFolder(Long groupId) {
		Folder folder = null;
		try {
			folder = DLAppServiceUtil.getFolder(groupId, PARENT_FOLDER_ID, "Competition");
			LOGGER.info("Folder exists: " + folder);
		} catch (Exception e) {
			LOGGER.error("Error creating folder: ", e);
		}
		return (folder != null) ? folder.getFolderId() : DLFolderConstants.DEFAULT_PARENT_FOLDER_ID;
	}

	@SuppressWarnings("deprecation")
	public Long fileUpload(java.io.File file, String filename, long groupId) {
		String mimeType = "application/pdf";
		String title = filename;
		String description = "ID card PDF generated programmatically";
		Long folderId = getFolder(groupId);
		try {
			FileEntry entry = DLAppServiceUtil.addFileEntry(groupId, folderId, title, mimeType, title, description, "",
					file, new ServiceContext());
			return entry.getFileEntryId();
		} catch (Exception e) {
			LOGGER.error("Error uploading ID card file: ", e);
		}
		return 0L;
	}
}