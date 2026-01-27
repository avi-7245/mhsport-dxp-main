package com.mhdsys.site.counter.portlet;

import com.liferay.portal.kernel.dao.orm.QueryUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;
import com.mhdsys.schema.model.SiteCounter;
import com.mhdsys.schema.service.SiteCounterLocalServiceUtil;
import com.mhdsys.site.counter.constants.MhdsysSiteCounterPortletKeys;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.portlet.Portlet;
import javax.portlet.PortletException;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.osgi.service.component.annotations.Component;

/**
 * @author Lenovo
 */
@Component(
	property = {
		"com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=false",
		"javax.portlet.display-name=MhdsysSiteCounter",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + MhdsysSiteCounterPortletKeys.MHDSYSSITECOUNTER,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class MhdsysSiteCounterPortlet extends MVCPortlet {
	
	private static final Log LOG = LogFactoryUtil.getLog(MhdsysSiteCounterPortlet.class);
	
	@Override
	public void doView(RenderRequest renderRequest, RenderResponse renderResponse)throws IOException, PortletException {
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		LOG.debug(themeDisplay.getLayout());
		/*
		 * LOG.info(themeDisplay.getUser()); LOG.info(themeDisplay.getRemoteAddr());
		 * LOG.info(themeDisplay.getRemoteHost());
		 * LOG.info(themeDisplay.getLifecycle()); LOG.info(themeDisplay.getDevice());
		 */
		boolean doIncrement = (themeDisplay.getLayout().getLayoutId() == 11) ? true : false;
		if (doIncrement) {
			try {
				incrementVisitorsCount();
			} catch (Exception e) {
				LOG.error(e.getMessage());
			}
		} else {
			// return;
		}

		SiteCounter todaysSiteCounter = null;
		try {
			todaysSiteCounter = SiteCounterLocalServiceUtil.findByUpdatedDate(getTodaysDate());
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}

		if (Validator.isNotNull(todaysSiteCounter)) {
			renderRequest.setAttribute("todaysCount", todaysSiteCounter.getTodayCount());
			renderRequest.setAttribute("totalCount", todaysSiteCounter.getTotalCount());
		} else {
			renderRequest.setAttribute("todaysCount", 0L);
			renderRequest.setAttribute("totalCount", 0L);
		}

		super.doView(renderRequest, renderResponse);
	}

	private SiteCounter incrementVisitorsCount() throws PortalException {
		Date todaysDate = getTodaysDate();

		SiteCounter siteCounter = null;
		try {
			siteCounter = SiteCounterLocalServiceUtil.findByUpdatedDate(todaysDate);
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}

		if (Validator.isNotNull(siteCounter)) {
			long updatedTodaysCount = siteCounter.getTodayCount() + 1;
			long updatedTotalCount = siteCounter.getTotalCount() + 1;
			SiteCounterLocalServiceUtil.updateSiteCounter(siteCounter.getSiteCounterId(), updatedTodaysCount,
					updatedTotalCount, todaysDate);
		} else {
			SiteCounterLocalServiceUtil.addSiteCounter(1, getTotalCount(), todaysDate);
		}

		return null;

	}

	private long getTotalCount() {
		List<SiteCounter> siteCounters = new ArrayList<SiteCounter>();

		try {
			siteCounters = SiteCounterLocalServiceUtil.getSiteCounters(QueryUtil.ALL_POS, QueryUtil.ALL_POS);
		} catch (SystemException e) {
			LOG.error(e.getMessage());
		}

		long totalCount = 0;
		if (Validator.isNotNull(siteCounters)) {
			for (SiteCounter siteCounter : siteCounters) {
				totalCount = totalCount + siteCounter.getTodayCount();
			}
		} else {
			return 0;
		}

		return totalCount;
	}

	private Date getTodaysDate() {
		String dateFormat = "yyyy-MM-dd";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(dateFormat);
		String currentDate = simpleDateFormat.format(new Date());

		try {
			return new SimpleDateFormat(dateFormat).parse(currentDate);
		} catch (Exception e) {
			LOG.error(e.getMessage());
		}

		return new Date();
	}
}