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
import com.mhdsys.schema.model.CompetitionResultUpload;
import com.mhdsys.schema.model.CompetitionSchedule;
import com.mhdsys.schema.service.CompetitionResultUploadLocalServiceUtil;
import com.mhdsys.schema.service.CompetitionScheduleLocalServiceUtil;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.imageio.ImageIO;
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
				+ CompetitionManagementWebPortletKeys.DOWNLOAD_WINNER_CERTIFICATE_MVC_RESOURCE_COMMAND }, service = MVCResourceCommand.class)

public class DownloadWinnerCertificateMVCResourceCommand implements MVCResourceCommand {

	private static final Log LOGGER = LogFactoryUtil.getLog(DownloadWinnerCertificateMVCResourceCommand.class);
	private static final long PARENT_FOLDER_ID = DLFolderConstants.DEFAULT_PARENT_FOLDER_ID;
	private static final SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

	@Override
	public boolean serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws PortletException {

		LOGGER.info("Generating Winner Certificate PDF...");

		long initiationId = ParamUtil.getLong(resourceRequest, "competitionInitiationId");
		long scheduleId = ParamUtil.getLong(resourceRequest, "competitionScheduledId");
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);

		try {
			// Fetch winner and competition data
			CompetitionResultUpload resultUpload = CompetitionResultUploadLocalServiceUtil.getByScheduleId(scheduleId);
			CompetitionSchedule competitionSchedule = CompetitionScheduleLocalServiceUtil
					.getCompetitionSchedule(scheduleId);

			if (resultUpload == null || competitionSchedule == null) {
				LOGGER.error("No competition data found for scheduleId: " + scheduleId);
				resourceResponse.getWriter().write("No result data found for this competition.");
				return false;
			}

			String winnerName = resultUpload.getWinnerName();
			String competitionName = competitionSchedule.getCompetitionName();
			String organizerName = competitionSchedule.getCompetitionOrganizerName();

			// Generate PDF
			ByteArrayOutputStream outputStream = generateWinnerCertificatePDF(winnerName, competitionName,
					organizerName, resourceRequest, resourceResponse, themeDisplay);

			// Set PDF response
			resourceResponse.setContentType("application/pdf");
			resourceResponse.addProperty("Content-Disposition",
					"attachment; filename=Winner_Certificate_" + resultUpload.getCompetitionResultUploadId() + ".pdf");

		} catch (Exception e) {
			LOGGER.error("Error generating winner certificate: ", e);
		}

		return false;
	}

	private ByteArrayOutputStream generateWinnerCertificatePDF(String winnerName, String competitionName,
			String organizerName, ResourceRequest resourceRequest, ResourceResponse resourceResponse,
			ThemeDisplay themeDisplay) throws IOException {

		PDDocument document = new PDDocument();
		PDPage page = new PDPage(PDRectangle.A4);
		document.addPage(page);
		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

		try (PDPageContentStream contentStream = new PDPageContentStream(document, page)) {
			float margin = 80;
			float startY = page.getMediaBox().getHeight() - margin;
			float centerX = page.getMediaBox().getWidth() / 2;

			// Background
			contentStream.setNonStrokingColor(new Color(240, 248, 255)); // Light blue background
			contentStream.addRect(0, 0, page.getMediaBox().getWidth(), page.getMediaBox().getHeight());
			contentStream.fill();

			// Add Logo (User portrait or site logo)
			try {
				long portraitId = themeDisplay.getUser().getPortraitId();
				if (portraitId > 0) {
					com.liferay.portal.kernel.model.Image portraitImage = com.liferay.portal.kernel.service.ImageLocalServiceUtil
							.getImage(portraitId);
					byte[] imageBytes = portraitImage.getTextObj();

					if (imageBytes != null && imageBytes.length > 0) {
						BufferedImage bufferedImage = ImageIO.read(new ByteArrayInputStream(imageBytes));
						PDImageXObject pdImage = LosslessFactory.createFromImage(document, bufferedImage);

						float imgWidth = 100;
						float imgHeight = 100;
						float imageX = page.getMediaBox().getWidth() - imgWidth - 70;
						float imageY = page.getMediaBox().getHeight() - imgHeight - 50;
						contentStream.drawImage(pdImage, imageX, imageY, imgWidth, imgHeight);
					}
				}
			} catch (Exception e) {
				LOGGER.warn("Unable to load logo or profile image: " + e.getMessage());
			}

			// Certificate Title
			contentStream.setNonStrokingColor(Color.BLACK);
			contentStream.setFont(PDType1Font.HELVETICA_BOLD, 24);
			drawCenteredText(contentStream, "Certificate of Achievement", centerX, startY - 100, -60);
			
			contentStream.setFont(PDType1Font.HELVETICA, 14);
			drawCenteredText(contentStream, "This is to proudly certify that", centerX, startY - 150);

			contentStream.setFont(PDType1Font.HELVETICA_BOLD, 22);
			drawCenteredText(contentStream, winnerName, centerX, startY - 190, -30);

			contentStream.setFont(PDType1Font.HELVETICA, 14);
			drawCenteredText(contentStream, "has demonstrated outstanding performance in", centerX, startY - 230);

			contentStream.setFont(PDType1Font.HELVETICA_BOLD, 16);
			drawCenteredText(contentStream, competitionName, centerX, startY - 260);

			contentStream.setFont(PDType1Font.HELVETICA, 13);
			drawCenteredText(contentStream, "Organized by: " + organizerName, centerX, startY - 300);

			contentStream.setFont(PDType1Font.HELVETICA, 12);
			drawCenteredText(contentStream, "Date: " + formatter.format(new Date()), centerX - 100, startY - 370);
			drawCenteredText(contentStream, "_________________________", centerX + 100, startY - 380);
			drawCenteredText(contentStream, "Authorized Signatory", centerX + 100, startY - 400);

			contentStream.close();

			// Save PDF
			document.save(outputStream);

			// Save and upload
			byte[] pdfBytes = outputStream.toByteArray();
			String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			String fileName = "Winner_Certificate_" + timestamp + ".pdf";

			File tempFile = File.createTempFile("winner_certificate_", ".pdf");
			try (FileOutputStream fos = new FileOutputStream(tempFile)) {
				fos.write(pdfBytes);
			}

			long fileEntryId = fileUpload(tempFile, fileName, themeDisplay.getScopeGroupId());
			FileEntry fileEntry = DLAppServiceUtil.getFileEntry(fileEntryId);
			String downloadURL = DLURLHelperUtil.getPreviewURL(fileEntry, fileEntry.getFileVersion(), themeDisplay, "");

			LOGGER.info("Download URL : " + downloadURL);

			JSONObject responseJson = JSONFactoryUtil.createJSONObject();
			responseJson.put("downloadURL", downloadURL);

			resourceResponse.setContentType("application/json");
			PrintWriter outPrint = resourceResponse.getWriter();
			outPrint.print(responseJson.toString());
			outPrint.flush();
			outPrint.close();

			tempFile.deleteOnExit();

		} catch (Exception e) {
			LOGGER.error("Error while generating certificate PDF", e);
		} finally {
			document.close();
		}

		return outputStream;
	}

	private void drawCenteredText(PDPageContentStream contentStream, String text, float centerX, float yPosition)
			throws IOException {
		float stringWidth = PDType1Font.HELVETICA.getStringWidth(text) / 1000 * 12;
		float startX = centerX - (stringWidth / 2);
		contentStream.beginText();
		contentStream.newLineAtOffset(startX, yPosition);
		contentStream.showText(text);
		contentStream.endText();
	}
	
	private void drawCenteredText(PDPageContentStream contentStream, String text, float centerX, float yPosition, float xOffset)
	        throws IOException {
	    float stringWidth = PDType1Font.HELVETICA.getStringWidth(text) / 1000 * 12;
	    float startX = centerX - (stringWidth / 2) + xOffset; 
	    contentStream.beginText();
	    contentStream.newLineAtOffset(startX, yPosition);
	    contentStream.showText(text);
	    contentStream.endText();
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
		String title = filename + ".pdf";
		String description = "Winner certificate PDF generated programmatically";
		Long folderId = getFolder(groupId);
		try {
			FileEntry entry = DLAppServiceUtil.addFileEntry(groupId, folderId, title, mimeType, title, description, "",
					file, new ServiceContext());
			return entry.getFileEntryId();
		} catch (Exception e) {
			LOGGER.error("Error uploading certificate file: ", e);
		}
		return 0L;
	}
}
