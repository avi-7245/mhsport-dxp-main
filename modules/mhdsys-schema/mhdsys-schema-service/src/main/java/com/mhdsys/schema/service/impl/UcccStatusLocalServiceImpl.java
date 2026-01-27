/**
 * SPDX-FileCopyrightText: (c) 2025 Liferay, Inc. https://liferay.com
 * SPDX-License-Identifier: LGPL-2.1-or-later OR LicenseRef-Liferay-DXP-EULA-2.0.0-2023-06
 */

package com.mhdsys.schema.service.impl;

import com.liferay.portal.aop.AopService;
import com.mhdsys.schema.model.UcccStatus;
import com.mhdsys.schema.service.base.UcccStatusLocalServiceBaseImpl;

import java.util.List;

import org.osgi.service.component.annotations.Component;

/**
 * @author Brian Wing Shun Chan
 */
@Component(
	property = "model.class.name=com.mhdsys.schema.model.UcccStatus",
	service = AopService.class
)
public class UcccStatusLocalServiceImpl extends UcccStatusLocalServiceBaseImpl {
	public List<UcccStatus> getByConstructionTrackerId(long constructionTrackerId) {
	    return ucccStatusPersistence.findByconstructionTrackerId(constructionTrackerId);
	}
	public void deleteAllByConstructionTrackerId(long constructionTrackerId) {
	    List<UcccStatus> list = ucccStatusPersistence.findByconstructionTrackerId(constructionTrackerId);

	    for (UcccStatus status : list) {
	        ucccStatusPersistence.remove(status);
	    }
	}

}