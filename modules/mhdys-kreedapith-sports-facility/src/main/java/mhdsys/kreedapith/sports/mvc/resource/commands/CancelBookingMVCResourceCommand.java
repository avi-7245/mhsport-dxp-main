package mhdsys.kreedapith.sports.mvc.resource.commands;

import com.liferay.petra.string.StringPool;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCResourceCommand;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.mhdsys.schema.model.sportsFacilityBooking;
import com.mhdsys.schema.service.sportsFacilityBookingLocalServiceUtil;

import java.io.IOException;

import javax.portlet.PortletException;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import org.osgi.service.component.annotations.Component;

import mhdys.kreedapith.sports.facility.constants.MhdysKreedapithSportsFacilityPortletKeys;

@Component(
		immediate=true,
	    property = { 
	    		"javax.portlet.name=" + MhdysKreedapithSportsFacilityPortletKeys.MHDYSKREEDAPITHSPORTSFACILITY,
	    		"mvc.command.name="+MhdysKreedapithSportsFacilityPortletKeys.CANCEL_BOOKING
	    }, 
	    service = MVCResourceCommand.class
)
public class CancelBookingMVCResourceCommand  implements MVCResourceCommand {
	
	private static final Log _log = LogFactoryUtil.getLog(CancelBookingMVCResourceCommand.class);
	
	@Override
	public boolean serveResource(ResourceRequest resourceRequest, ResourceResponse resourceResponse)
			throws PortletException {
			_log.info("Entry into CancelBookingMVCResourceCommand ::  serveResource ::");
			JSONObject jsonObject = JSONFactoryUtil.createJSONObject();
			 sportsFacilityBooking sportsFacilityBooking=null;
			long bookingId =ParamUtil.getLong(resourceRequest,"bookingId");
			_log.info("bookingId :::"+bookingId);
			String message=StringPool.BLANK;
			if(Validator.isNotNull(bookingId) && bookingId>0){
					  try {
						sportsFacilityBooking = sportsFacilityBookingLocalServiceUtil.getsportsFacilityBooking(bookingId);
					} catch (Exception e) {
						_log.error("Error in code :::" +e);
					}
			}
			_log.info("sportsFacilityBooking :::"+ sportsFacilityBooking);
			if(Validator.isNotNull(sportsFacilityBooking)){
				//Delete here 
				try {
					sportsFacilityBookingLocalServiceUtil.deletesportsFacilityBooking(bookingId);
					message="success";
				} catch (Exception e) {
					_log.error("Error in code ::" +e);
				}
			}else {
				message="error";
			}
			jsonObject.put("message", message);
			_log.info("jsonObject :::" +jsonObject);
			try {
				resourceResponse.getWriter().print(jsonObject.toJSONString());
			} catch (IOException e) {
				_log.error("Error in code :::" +e);
			}
		return false;
	}
	
}

