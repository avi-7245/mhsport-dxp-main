/**
 * SPDX-FileCopyrightText: (c) 2025 Liferay, Inc. https://liferay.com
 * SPDX-License-Identifier: LGPL-2.1-or-later OR LicenseRef-Liferay-DXP-EULA-2.0.0-2023-06
 */

package com.mhdsys.schema.service.impl;

import com.liferay.portal.aop.AopService;
import com.mhdsys.schema.model.SportsFacilityMaster;
import com.mhdsys.schema.service.base.SportsFacilityMasterLocalServiceBaseImpl;

import java.util.ArrayList;
import java.util.List;

import org.osgi.service.component.annotations.Component;

/**
 * @author VenuGopal
 */
@Component(
	property = "model.class.name=com.mhdsys.schema.model.SportsFacilityMaster",
	service = AopService.class
)
public class SportsFacilityMasterLocalServiceImpl
	extends SportsFacilityMasterLocalServiceBaseImpl {
	
	public List<SportsFacilityMaster> getByfacilityName(String facilityName) {
		return sportsFacilityMasterPersistence.findByfacilityName(facilityName);
	}
	
	public List<SportsFacilityMaster> getByfacilityType(String facilityType) {
		return sportsFacilityMasterPersistence.findByfacilityType(facilityType);
	}
	
	public List<SportsFacilityMaster> getByType(String type) {
		return sportsFacilityMasterPersistence.findBytype(type);
	}
	
	public List<SportsFacilityMaster> getByCreatorUserId(long creatorUserId) {
		return sportsFacilityMasterPersistence.findBycreatorUserId(creatorUserId);
	}
	
	
	public List<SportsFacilityMaster> getByDistrictId(long districtId) {
		return sportsFacilityMasterPersistence.findByDistrictId(districtId);
	}
	
	public List<SportsFacilityMaster> getByFacilityLocation(String facilityLocation) {
		return sportsFacilityMasterPersistence.findByFacilityLocation(facilityLocation);
	}
	
	public List<SportsFacilityMaster> getByFacilityTypeAndDivision(String facilityType,long divisionId) {
		return sportsFacilityMasterPersistence.findByFacilityTypeAndDivision(facilityType, divisionId);
	}
	
	public List<SportsFacilityMaster> getByFacilityTypeAndDistrict(String facilityType,long districtId) {
		return sportsFacilityMasterPersistence.findByFacilityTypeAndDistrict(facilityType, districtId);
	}
	
	public List<SportsFacilityMaster> getByByFacilityTypeAndTaluka(String facilityType,long talukaId) {
		return sportsFacilityMasterPersistence.findByFacilityTypeAndTaluka(facilityType, talukaId);
	}
	
	public List<SportsFacilityMaster> getByFacilityType(List<String>facilityTypes) {
	    List<SportsFacilityMaster> combinedList = new ArrayList<>();

	    for (String type : facilityTypes) {
	        List<SportsFacilityMaster> tempList = sportsFacilityMasterPersistence.findByTypeOfFacility(type);
	        combinedList.addAll(tempList); 
	    }

	    return combinedList;
	}

	
}