package com.mhdsys.common.util;

import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.model.UserNotificationEvent;
import com.liferay.portal.kernel.notifications.BaseUserNotificationHandler;
import com.liferay.portal.kernel.notifications.UserNotificationHandler;
import com.liferay.portal.kernel.service.ServiceContext;

import org.osgi.service.component.annotations.Component;

@Component(immediate = true, service = UserNotificationHandler.class)
public class NotificationHandler extends BaseUserNotificationHandler {

	private static final String CUSTOM_PORTLET_ID = "SPORTS_NOTIFICATION_PORTLET_ID";

	public NotificationHandler() {
		setPortletId(CUSTOM_PORTLET_ID);
	}

	@Override
	protected String getBody(UserNotificationEvent userNotificationEvent, ServiceContext serviceContext)
			throws Exception {
		return JSONFactoryUtil.createJSONObject(userNotificationEvent.getPayload()).getString("notificationTemplate");
	}

	@Override
	protected String getLink(UserNotificationEvent userNotificationEvent, ServiceContext serviceContext)
			throws Exception {
		return JSONFactoryUtil.createJSONObject(userNotificationEvent.getPayload()).getString("url");
	}

	@Override
	protected String getTitle(UserNotificationEvent userNotificationEvent, ServiceContext serviceContext)
			throws Exception {

		return JSONFactoryUtil.createJSONObject(userNotificationEvent.getPayload()).getString("title");
	}

}
