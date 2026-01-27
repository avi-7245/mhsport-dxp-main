package mhdsys.kreedapith.sports.mvc.resource.commands;

import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.document.library.kernel.model.DLFileEntry;
import com.liferay.petra.string.StringPool;
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
import com.mhdsys.common.api.sportsFacilityBooking.SportsFacilityBookingCommonApi;
import com.mhdsys.common.util.FileUploadUtil;
import com.mhdsys.schema.model.sportsFacilityBooking;
import com.mhdsys.schema.service.sportsFacilityBookingLocalServiceUtil;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;

import javax.portlet.PortletException;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

import mhdsys.sports.facility.web.util.SportsFacilityCommonUtil;
import mhdys.kreedapith.sports.facility.constants.MhdysKreedapithSportsFacilityPortletKeys;

@Component
(immediate = true, property = { "javax.portlet.name=" + MhdysKreedapithSportsFacilityPortletKeys.MHDYSKREEDAPITHSPORTSFACILITY,
		"mvc.command.name="+ MhdysKreedapithSportsFacilityPortletKeys.SAVE_FACILITY_BOOKING}, service = MVCResourceCommand.class)
public class SaveFacilityAndAdminApprovalFacilityResourceCommand implements MVCResourceCommand{
	private Log _log = LogFactoryUtil.getLog(SaveFacilityAndAdminApprovalFacilityResourceCommand.class);
	
	@Override
	public boolean serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws PortletException {
		
		_log.info("Entry into SaveFacilityAndAdminApprovalFacilityResourceCommand :::" );
		
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		 UploadPortletRequest uploadRequest = PortalUtil.getUploadPortletRequest(resourceRequest);
		
		//String mode= ParamUtil.getString(resourceRequest, "mode");
		String customerName= ParamUtil.getString(resourceRequest, "customerName");
		String customerEmail= ParamUtil.getString(resourceRequest, "customerEmail");
		String customerPhone= ParamUtil.getString(resourceRequest, "customerPhone");
		String startTime= ParamUtil.getString(resourceRequest, "startTime");
		String endTime= ParamUtil.getString(resourceRequest, "endTime");
		String bookingDate= ParamUtil.getString(resourceRequest, "bookingDate");
		String bookingType= ParamUtil.getString(resourceRequest, "bookingType");
		String bookingFacilityName=ParamUtil.getString(resourceRequest, "bookingFacilityName");
		long bookingFacilityId=ParamUtil.getLong(resourceRequest, "bookingFacilityId");
		String bookingFacilityCourt=ParamUtil.getString(resourceRequest, "bookingFacilityCourt");
		String bookingFor=ParamUtil.getString(resourceRequest, "BookingFor");//for hourly
		String dayBookingFor=ParamUtil.getString(resourceRequest, "dayBookingFor");
		String monthBookingFor=ParamUtil.getString(resourceRequest, "monthBookingFor");
		//String dayBookingFor=ParamUtil.getString(resourceRequest, "MonthBookingFor");
		double bookingACFees=ParamUtil.getDouble(resourceRequest, "bookingACFees");
		double bookingArenaLightFees=ParamUtil.getDouble(resourceRequest, "bookingArenaLightFees");
		boolean isHourlyACBooking=ParamUtil.getBoolean(resourceRequest, "ac-hourly");
		boolean isAcHourlyChecked=ParamUtil.getBoolean(resourceRequest, "isAcHourlyChecked");
		boolean isArenaLightChecked=ParamUtil.getBoolean(resourceRequest, "isArenaLightChecked");
		boolean isHourlyArenaLights=ParamUtil.getBoolean(resourceRequest, "arenalights");
		
		//Add new 
		String facilityLevelVal=ParamUtil.getString(resourceRequest, "facilityLevelVal");
		long divisionVal=ParamUtil.getLong(resourceRequest, "divisionVal");
		long districtVal=ParamUtil.getLong(resourceRequest, "districtVal");
		long talukaVal=ParamUtil.getLong(resourceRequest, "talukaVal");
		
		_log.info("facilityLevelVal ::::" +facilityLevelVal);
		_log.info("divisionVal ::::" +divisionVal);
		_log.info("districtVal ::::" +districtVal);
		_log.info("talukaVal ::::" +talukaVal);
		
		//double totalFinalAmount=ParamUtil.getDouble(resourceRequest, "totalFinalAmount");
		
		int noofmonth = ParamUtil.getInteger(resourceRequest, "noofmonth");
		int nofodays = ParamUtil.getInteger(resourceRequest, "nofodays");
		
		Double totalFinalAmount=ParamUtil.getDouble(resourceRequest, "totalFinalAmount");
		String purpose=StringPool.BLANK;
		String facilityBookingType=StringPool.BLANK;
		
		_log.info("nofodays ::::" +nofodays);
		_log.info("noofmonth ::::" +noofmonth);
		_log.info("dayBookingFor ::::" +dayBookingFor);
		_log.info("isAcHourlyChecked ::::" +isAcHourlyChecked);
		_log.info("isArenaLightChecked ::::" +isArenaLightChecked);
		_log.info("bookingACFees ::::" +bookingACFees);
		_log.info("bookingArenaLightFees ::::" +bookingArenaLightFees);
		_log.info("isACBooking ::::" +isHourlyACBooking);
		_log.info("isArenaLights ::::" +isHourlyArenaLights);
		_log.info("totalFinalAmount ::::" +totalFinalAmount);
		_log.info("bookingFor ::::=====================================" +bookingFor);
		_log.info("bookingFacilityId ::::" +bookingFacilityId);
		_log.info("bookingFacilityName ::::" +bookingFacilityName);
		_log.info("bookingFacilityCourt ::::" +bookingFacilityCourt);
		_log.info("customerEmail ::::" +customerEmail);
		_log.info("customerName ::::" +customerName);
		_log.info("customerPhone ::::" +customerPhone);
		_log.info("startTime ::::" +startTime);
		_log.info("endTime ::::" +endTime);
		_log.info("bookingDate ::::" +bookingDate);
		_log.info("bookingType ::::" +bookingType);
		
		 DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy").withZone(ZoneId.systemDefault());
	     String formattedDate = formatter.format(Instant.parse(bookingDate));
	     DateFormat format=new SimpleDateFormat("dd-MM-yyyy"); 
	     
	     try {
			_log.info("date booking ::::" +format.parse(formattedDate));
		} catch (ParseException e) {
			_log.error("Error in code ::" +e);
		}
	     
	     if("daily-tab".equalsIgnoreCase(bookingType)){
	    	 purpose=dayBookingFor;
	    	 facilityBookingType="daily";
	     }else if("hourly-tab".equalsIgnoreCase(bookingType)){
	    	 purpose=bookingFor;
	    	 facilityBookingType="hourly";
	     }else if("monthly-tab".equalsIgnoreCase(bookingType)){
	    	 purpose=monthBookingFor;
	    	 facilityBookingType="monthly";
	     }
	     
	     _log.info("facilityBookingType :::" +facilityBookingType);
	     _log.info("purpose :::" +purpose);
	     
	     
	     
	     //folder name :SportsFacilityBooking
	     //File upload code  if shooting is selected
	     ServiceContext serviceContext=null;
	     long fileEntryId=0; 
		try {
			serviceContext = ServiceContextFactory.getInstance(DLFileEntry.class.getName(), uploadRequest);
		} catch (Exception e) {
			_log.error("Error in code:::" +e);
		}
	     try {
	    	 fileEntryId= fileUploadUtil.uploadFile(uploadRequest, "licenseDoc", "SportsFacilityBooking", serviceContext);
		} catch (Exception e) {
			_log.error("Error in code:::" +e);
		}
	     
	    _log.error("fileEntryId :::::::::::::::::::" +fileEntryId); 
	     
		//Add Booking 
		try {
			long bookingId = CounterLocalServiceUtil.increment(sportsFacilityBooking.class.getName());
			sportsFacilityBooking sportsFacilityBooking = sportsFacilityBookingLocalServiceUtil.createsportsFacilityBooking(bookingId);
			sportsFacilityBooking.setCreatorUserId(themeDisplay.getUserId());
			sportsFacilityBooking.setSelectedFacility(bookingFacilityId);
			sportsFacilityBooking.setType(facilityBookingType);
			sportsFacilityBooking.setTimeFrom(startTime);
			sportsFacilityBooking.setTimeTo(endTime);
			sportsFacilityBooking.setPurpose(purpose);
			sportsFacilityBooking.setName(customerName);
			sportsFacilityBooking.setDate(format.parse(formattedDate));
			sportsFacilityBooking.setContact(customerPhone);
			sportsFacilityBooking.setEmail(customerEmail);
			sportsFacilityBooking.setBookingStatus(0);;
			sportsFacilityBooking.setFees(totalFinalAmount.toString());
			sportsFacilityBooking.setSportCourt(bookingFacilityCourt);
			sportsFacilityBooking.setIsApproved(Boolean.FALSE);
			sportsFacilityBooking.setCreateDate(new Date());
			sportsFacilityBooking.setModifiedDate(new Date());
			sportsFacilityBooking.setFacilityLevel(facilityLevelVal);
			sportsFacilityBooking.setDivision(divisionVal);
			sportsFacilityBooking.setDistrict(districtVal);
			sportsFacilityBooking.setTaluka(talukaVal);
			
			if(Validator.isNotNull(fileEntryId) && fileEntryId>0) {
				sportsFacilityBooking.setFirearmAndAmmunitionLicense(fileEntryId);
			}
			
			sportsFacilityBookingLocalServiceUtil.updatesportsFacilityBooking(sportsFacilityBooking);
		} catch (Exception e) {
			_log.error("Error in code :::" + e);
		}
		
		try {
			resourceResponse.getWriter().write("success");
		} catch (Exception e) {
			_log.error("Error in code :::" +e);
		}
		_log.info("SaveFacilityBookingResourceCommand Ends ---------------");
		return false;
	}

	@Reference private SportsFacilityBookingCommonApi _sportsFacilityBookingCommonApi;
	@Reference private SportsFacilityCommonUtil _SportsFacilityCommonUtil;
	
	@Reference
	FileUploadUtil fileUploadUtil;
}
