/**
 * SPDX-FileCopyrightText: (c) 2025 Liferay, Inc. https://liferay.com
 * SPDX-License-Identifier: LGPL-2.1-or-later OR LicenseRef-Liferay-DXP-EULA-2.0.0-2023-06
 */

package com.mhdsys.schema.service.impl;

import com.liferay.portal.aop.AopService;
import com.liferay.portal.kernel.exception.PortalException;
import com.mhdsys.schema.exception.NoSuchSiteCounterException;
import com.mhdsys.schema.model.SiteCounter;
import com.mhdsys.schema.service.base.SiteCounterLocalServiceBaseImpl;

import java.util.Date;

import org.osgi.service.component.annotations.Component;

/**
 * @author Brian Wing Shun Chan
 */
@Component(
	property = "model.class.name=com.mhdsys.schema.model.SiteCounter",
	service = AopService.class
)
public class SiteCounterLocalServiceImpl
	extends SiteCounterLocalServiceBaseImpl {
	
	public SiteCounter addSiteCounter(long todayCount, long totalCount, Date updatedDate) {
		SiteCounter siteCounter = siteCounterPersistence.create(counterLocalService.increment(SiteCounter.class.getName()));
		siteCounter.setTodayCount(todayCount);
		siteCounter.setTotalCount(totalCount);
		siteCounter.setUpdatedDate(updatedDate);
		return siteCounterPersistence.update(siteCounter);
	}
	
	public SiteCounter updateSiteCounter(long siteCounterId, long todayCount, long totalCount, Date updatedDate) throws PortalException {
		SiteCounter siteCounter = siteCounterLocalService.getSiteCounter(siteCounterId);
		siteCounter.setTodayCount(todayCount);
		siteCounter.setTotalCount(totalCount);
		siteCounter.setUpdatedDate(updatedDate);
		return siteCounterPersistence.update(siteCounter);
	}
	
	public SiteCounter findByUpdatedDate(Date updatedDate) throws NoSuchSiteCounterException {
		return siteCounterPersistence.findByUpdatedDate(updatedDate);
	}
}