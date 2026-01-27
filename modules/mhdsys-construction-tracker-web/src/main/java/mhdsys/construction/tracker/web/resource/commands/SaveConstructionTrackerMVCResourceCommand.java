package mhdsys.construction.tracker.web.resource.commands;

import com.liferay.document.library.kernel.model.DLFileEntry;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.service.ServiceContextFactory;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.upload.UploadPortletRequest;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.common.api.constructionTracker.ConstructionTrackerCommonApi;
import com.mhdsys.common.api.uccc.status.UcccStatusCommonApi;
import com.mhdsys.common.pojo.ConstructionTrackerCommonDTO;
import com.mhdsys.common.pojo.UcccStatusDTO;
import com.mhdsys.common.util.FileUploadUtil;
import com.mhdsys.common.utility.constants.CommonUtilityConstant;
import com.mhdsys.schema.model.ConstructionTracker;
import com.mhdsys.schema.model.UcccStatus;
import com.mhdsys.schema.service.UcccStatusLocalServiceUtil;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.portlet.PortletException;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import mhdsys.construction.tracker.web.constants.MhdsysConstructionTrackerWebPortletKeys;
import mhdsys.construction.tracker.web.util.ConstructionTrackerUtil;

@Component(immediate = true, property = { "javax.portlet.name=" + MhdsysConstructionTrackerWebPortletKeys.MHDSYSCONSTRUCTIONTRACKERWEB,
		"mvc.command.name="
				+ MhdsysConstructionTrackerWebPortletKeys.SAVE_CONSTRUCTIONTRACKER_RESOURCECOMMAND}, service = MVCResourceCommand.class)

public class SaveConstructionTrackerMVCResourceCommand implements MVCResourceCommand{
	private Log _log = LogFactoryUtil.getLog(SaveConstructionTrackerMVCResourceCommand.class);

	@Override
	public boolean serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws PortletException {
		DateFormat daterFormatter = new SimpleDateFormat("yyyy-MM-dd");
		_log.info("SaveConstructionTrackerMVCResourceCommand Started ------------------------------------");
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		String mode= ParamUtil.getString(resourceRequest, "mode");
		try {
			if(!("view".equalsIgnoreCase(mode))) {
				
					ConstructionTrackerCommonDTO constructionTrackerCommonDTO = constructionTrackerUtil.setConstructionTrackerCommonDTO(resourceRequest,themeDisplay);
					_log.info("constructionTrackerCommonDTO::::::::::  " + constructionTrackerCommonDTO);
					ConstructionTracker constructionTrackerModal = constructionTrackerCommonApi.saveConstructionTracker(constructionTrackerCommonDTO);
					_log.info("*********************************************************************************************");
					_log.info("Saved constructionTrackerModal::::::::::  " + constructionTrackerModal);
					String UCCCAmount= ParamUtil.getString(resourceRequest, "UCCCAmount");
					if(ParamUtil.getString(resourceRequest, "UCCCExtension").equals("Yes") && Validator.isNotNull(UCCCAmount)) {
						UcccStatusLocalServiceUtil.deleteAllByConstructionTrackerId(constructionTrackerModal.getConstructionTrackerId());
						int ucccIndex = 0;
						UcccStatusDTO ucccStatusDTO=new UcccStatusDTO();
						while(true) {
					    String UCCCRevisedCompletionDateStr=ParamUtil.getString(resourceRequest, "UCCCRevisedCompletionDate_"+ucccIndex);
					    String ucccWorkCompletedInTimelineStr=ParamUtil.getString(resourceRequest, "ucccWorkCompletedInTimeline_"+ucccIndex);
					    String UCCCReasonStr=ParamUtil.getString(resourceRequest, "UCCCReason_"+ucccIndex);
					    String panalActionStr=ParamUtil.getString(resourceRequest, "panalAction_"+ucccIndex);
					    if (Validator.isNull(UCCCRevisedCompletionDateStr) &&
						        Validator.isNull(ucccWorkCompletedInTimelineStr) &&
						        Validator.isNull(UCCCReasonStr) &&
						        Validator.isNull(panalActionStr)) {
						        break;
						    }
					    ucccStatusDTO.setConstructionTrackerId(constructionTrackerModal.getConstructionTrackerId());
						ucccStatusDTO.setCreatedDate(new Date());
						ucccStatusDTO.setModifiedDate(new Date());
						ucccStatusDTO.setPenalAction(panalActionStr);
						ucccStatusDTO.setUcccRevisedCompletionDate(Validator.isNotNull(UCCCRevisedCompletionDateStr)?daterFormatter.parse(UCCCRevisedCompletionDateStr):null);
					    ucccStatusDTO.setUcccReason(UCCCReasonStr);
					    ucccStatusDTO.setWorkCompletedInTimeline(ucccWorkCompletedInTimelineStr);
					    
					    UploadPortletRequest uploadPortletRequest = PortalUtil.getUploadPortletRequest(resourceRequest);
						ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFileEntry.class.getName(),
								uploadPortletRequest);
						long imageId=ParamUtil.getLong(resourceRequest, "imageId_"+ucccIndex);
						_log.info("imageId::::::::"+imageId);
						if (imageId > 0) {
							ucccStatusDTO.setPenalActionDoc(imageId);

						}else {
						if (uploadPortletRequest != null && uploadPortletRequest.getFile("panalActionDoc_"+ucccIndex) != null) {

							long panalActionDoc = fileUploadUtil.uploadFile(uploadPortletRequest, "panalActionDoc_"+ucccIndex,
									"ConstructionTracker", serviceContext);
							_log.info("panalActionDoc_"+ucccIndex+" "+ panalActionDoc);
							ucccStatusDTO.setPenalActionDoc(panalActionDoc);
						}
						}
					    
					    UcccStatus ucccStatus=ucccStatusCommonApi.saveUcccStatus(ucccStatusDTO);
					    _log.info("ucccStatus:::::::::"+ucccStatus.getUcccId());
					    ucccIndex++;
					    }
					}else {
						UcccStatusLocalServiceUtil.deleteAllByConstructionTrackerId(constructionTrackerModal.getConstructionTrackerId());
					}
					JSONObject responseJson = JSONFactoryUtil.createJSONObject();
					responseJson.put("status", "success");
					responseJson.put("conTrackerId", constructionTrackerModal.getConstructionTrackerId());
					_log.info("responseJson:: "+responseJson);
					resourceResponse.getWriter().write(responseJson.toString());
					
			}else {
				resourceResponse.getWriter().write("failed");
			}
		
		} catch (Exception e) {
			e.printStackTrace();
		}
		_log.info("SaveConstructionTrackerMVCResourceCommand Ended ------------------------------------");
		
		return false;
	
	}


	@Reference private ConstructionTrackerUtil constructionTrackerUtil;
	@Reference ConstructionTrackerCommonApi constructionTrackerCommonApi;
    @Reference UcccStatusCommonApi ucccStatusCommonApi;
    @Reference
	FileUploadUtil fileUploadUtil;
	
}
