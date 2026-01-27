package mhdsys.sports.facility.web.util;

import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.document.library.kernel.model.DLFileEntry;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.Role;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.service.RoleLocalServiceUtil;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.service.ServiceContextFactory;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.upload.UploadPortletRequest;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.Validator;
import com.mhdsys.common.api.sportsFacilityMaster.SportsFacilityMasterCommonApi;
import com.mhdsys.common.pojo.FacilityRatingCommonDTO;
import com.mhdsys.common.pojo.SportsFacilityBookingDTO;
import com.mhdsys.common.pojo.SportsFacilityMasterDTO;
import com.mhdsys.common.util.FileUploadUtil;
import com.mhdsys.common.utility.constants.RoleConstant;
import com.mhdsys.schema.model.DistrictMaster;
import com.mhdsys.schema.model.DivisionMaster;
import com.mhdsys.schema.model.SportsFacilityMaster;
import com.mhdsys.schema.model.TalukaMaster;
import com.mhdsys.schema.service.SportsFacilityMasterLocalServiceUtil;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.portlet.ResourceRequest;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;


@Component(immediate = true, service = SportsFacilityCommonUtil.class)
public class SportsFacilityCommonUtil {
	private final Log _log=LogFactoryUtil.getLog(SportsFacilityCommonUtil.class);
	@Reference FileUploadUtil fileUploadUtil;
	DateFormat daterFormatter = new SimpleDateFormat("yyyy-MM-dd");
	
	
	public SportsFacilityMasterDTO setSportsFacilityMasterDTO(ResourceRequest resourceRequest,ThemeDisplay themeDisplay) {
		
		
		SportsFacilityMasterDTO SportsFacilityMasterDTO = new SportsFacilityMasterDTO(); 
		
		try {
			_log.info("Inside Set DTO --------------------- ");
			User user = UserLocalServiceUtil.getUser(themeDisplay.getUserId());
			boolean isHOAdmin = RoleConstant.isHOAdmin(user, themeDisplay.getCompanyId());
			boolean isDDD = RoleConstant.isDDD(user, themeDisplay.getCompanyId());
			boolean isDSO = false;
			boolean isTSO = false;
		        List<Role> userRoles = RoleLocalServiceUtil.getUserRoles(user.getUserId());
		        for (Role role : userRoles) {
		            if (role.getName().endsWith("-DSO")) {
		            	isDSO = true;
		            }
		            if (role.getName().endsWith("-TSO") || role.getName().startsWith("TSO-")) {
		            	isTSO = true;
		            }
		        }
		        
//		        SET ATTRIBUTES
		        String mode= ParamUtil.getString(resourceRequest, "mode");
				String actionType = ParamUtil.getString(resourceRequest, "actionType");
				
				long sportsFacilityFormId = ParamUtil.getLong(resourceRequest, "sportsFacilityFormId");
				_log.info("sportsFacilityFormId while setting -- "+sportsFacilityFormId);
				SportsFacilityMasterDTO.setSportsFacilityId(sportsFacilityFormId);
				
//					If HO - These should save if the mode is save, If mode is edit DSO/TSO fieds shoun't efffect (because that data is already stored if edit)

					SportsFacilityMasterDTO.setFacilityName(ParamUtil.getString(resourceRequest, "facilityName"));
					SportsFacilityMasterDTO.setSportsCourt(ParamUtil.getString(resourceRequest, "sportsCourt"));
					SportsFacilityMasterDTO.setFacilityArea(ParamUtil.getString(resourceRequest, "facilityArea"));
					SportsFacilityMasterDTO.setLongitude(ParamUtil.getString(resourceRequest, "longitude"));
					SportsFacilityMasterDTO.setLatitude(ParamUtil.getString(resourceRequest, "latitude"));
//					SportsFacilityMasterDTO.setFees(ParamUtil.getString(resourceRequest, "fees"));
//					String[] selectedTypes = ParamUtil.getParameterValues(resourceRequest, "typeCheckBox");
//					String joinedTypes = String.join(", ", selectedTypes);
//					SportsFacilityMasterDTO.setType(joinedTypes);
					SportsFacilityMasterDTO.setIsUpdatedByHO(true);
					SportsFacilityMasterDTO.setModifiedDate(new Date());
					
					SportsFacilityMasterDTO.setDivision(ParamUtil.getLong(resourceRequest, "division"));
					SportsFacilityMasterDTO.setDistrict(ParamUtil.getLong(resourceRequest, "district"));
					SportsFacilityMasterDTO.setTaluka(ParamUtil.getLong(resourceRequest, "taluka"));
					
					SportsFacilityMasterDTO.setFacilityLocation("Shiv Chhtrapati Sports Complex");
					SportsFacilityMasterDTO.setSportsName(ParamUtil.getString(resourceRequest, "sportsName"));

					// Association & Federation
					SportsFacilityMasterDTO.setAssoc_fed_perHour(ParamUtil.getLong(resourceRequest, "assocPerHour"));
					SportsFacilityMasterDTO.setAssoc_fed_perDay(ParamUtil.getDouble(resourceRequest, "assocPerDay"));
					SportsFacilityMasterDTO.setAssoc_fed_perMonth(ParamUtil.getDouble(resourceRequest, "assocPerMonth"));

					// Rent for Other Sports Events
					SportsFacilityMasterDTO.setRent_other_sports_perHour(ParamUtil.getDouble(resourceRequest, "rentOtherPerHour"));
					SportsFacilityMasterDTO.setRent_other_sports_perDay(ParamUtil.getDouble(resourceRequest, "rentOtherPerDay"));
					SportsFacilityMasterDTO.setRent_other_sports_perMonth(ParamUtil.getDouble(resourceRequest, "rentOtherPerMonth"));

					// Rent for Non-Sports Events
					SportsFacilityMasterDTO.setRent_nonsports_perHour(ParamUtil.getDouble(resourceRequest, "rentNonPerHour"));
					SportsFacilityMasterDTO.setRent_nonsports_perDay(ParamUtil.getDouble(resourceRequest, "rentNonPerDay"));
					SportsFacilityMasterDTO.setRent_nonsports_perMonth(ParamUtil.getDouble(resourceRequest, "rentNonPerMonth"));

					// Individual
					SportsFacilityMasterDTO.setIndividual_perHour(ParamUtil.getDouble(resourceRequest, "indPerHour"));
					SportsFacilityMasterDTO.setIndividual_perDay(ParamUtil.getDouble(resourceRequest, "indPerDay"));
					SportsFacilityMasterDTO.setIndividual_perMonth(ParamUtil.getDouble(resourceRequest, "indPerMonth"));

					// Shooting – Rapid Event
					SportsFacilityMasterDTO.setShooting_rapid_perHour(ParamUtil.getDouble(resourceRequest, "shootingPerHour"));
					SportsFacilityMasterDTO.setShooting_rapid_perDay(ParamUtil.getDouble(resourceRequest, "shootingPerDay"));
					SportsFacilityMasterDTO.setShooting_rapid_perMonth(ParamUtil.getDouble(resourceRequest, "shootingPerMonth"));

					// Arena Lights & AC
					SportsFacilityMasterDTO.setArena_lights_perHour(ParamUtil.getDouble(resourceRequest, "lightsPerHour"));
					SportsFacilityMasterDTO.setAc_perHour(ParamUtil.getDouble(resourceRequest, "acPerHour"));

					SportsFacilityMasterDTO.setFacilityType(ParamUtil.getString(resourceRequest, "facilityType"));
					SportsFacilityMasterDTO.setContactPersonEmail(ParamUtil.getString(resourceRequest, "contactPersonEmail"));
					SportsFacilityMasterDTO.setCity(ParamUtil.getString(resourceRequest, "city"));
					SportsFacilityMasterDTO.setAddress(ParamUtil.getString(resourceRequest, "address"));
					SportsFacilityMasterDTO.setMainTypeOfFacility(ParamUtil.getString(resourceRequest, "mainTypeOfFacility"));
					SportsFacilityMasterDTO.setCourtNameNumber(ParamUtil.getString(resourceRequest, "courtNameNumber"));
					SportsFacilityMasterDTO.setAvailableFacilities(ParamUtil.getString(resourceRequest, "availableFacilities"));
					SportsFacilityMasterDTO.setNotWorkingReason(ParamUtil.getString(resourceRequest, "notWorkingReason"));
					SportsFacilityMasterDTO.setCapacity(ParamUtil.getString(resourceRequest, "capacity"));
					SportsFacilityMasterDTO.setRemarks(ParamUtil.getString(resourceRequest, "remarks"));
					
					
			        
					if("save".equalsIgnoreCase(actionType)) {
						SportsFacilityMasterDTO.setCreatorUserId(themeDisplay.getUserId()); // While update directly setting in service class
					}
					SportsFacilityMasterDTO.setHoAction(isHOAdmin);
					
//				IF DSO/TSO - All data including HO fields should save if the mode is save
				if((isDSO || isTSO || isDDD) && "edit".equalsIgnoreCase(actionType)) {
					
					SportsFacilityMasterDTO.setBookingUrl(ParamUtil.getString(resourceRequest, "bookingUrl"));
					SportsFacilityMasterDTO.setContactPersonName(ParamUtil.getString(resourceRequest, "contactPersonName"));
					SportsFacilityMasterDTO.setContactPersonNumber(ParamUtil.getString(resourceRequest, "contactPersonNumber"));
					if (isDDD) {
					    SportsFacilityMasterDTO.setIsUpdatedByDDD(true);
					} else {
					    SportsFacilityMasterDTO.setIsUpdatedByDSO(true);
					}
					UploadPortletRequest uploadRequest = PortalUtil.getUploadPortletRequest(resourceRequest);
					ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFileEntry.class.getName(), uploadRequest);

					JSONArray geoTagFileArray = JSONFactoryUtil.createJSONArray();
					String geoTagPhotoJson = ParamUtil.getString(uploadRequest, "geoTagPhotoHiddenInput");

					if (Validator.isNotNull(geoTagPhotoJson)) {
					    JSONArray inputArray = JSONFactoryUtil.createJSONArray(geoTagPhotoJson);
					    File[] uploadedFiles = uploadRequest.getFiles("GeoTagPhoto");
					    String[] uploadedFileNames = uploadRequest.getFileNames("GeoTagPhoto");
					    int fileUploadIndex = 0;

					    for (int i = 0; i < inputArray.length(); i++) {
					        JSONObject fileJson = inputArray.getJSONObject(i);
					        if (fileJson.has("markedForDelete") && fileJson.getBoolean("markedForDelete")) {
					            continue;
					        }

					        JSONObject resultJson = JSONFactoryUtil.createJSONObject();

					        if (fileJson.has("isExisting") && fileJson.getBoolean("isExisting")) {
					            resultJson.put("fileEntryId", fileJson.getLong("fileEntryId"));
					            resultJson.put("fileName", fileJson.getString("name"));
					        } else {
					            if (fileUploadIndex < uploadedFiles.length) {
					                File file = uploadedFiles[fileUploadIndex];
					                String fileName = uploadedFileNames[fileUploadIndex];
					                long fileEntryId = fileUploadUtil.multipleFileUpload(
					                    uploadRequest, "GeoTagPhoto", "SportsFacilityMaster", serviceContext, fileName, file
					                );
					                resultJson.put("fileEntryId", fileEntryId);
					                resultJson.put("fileName", fileName);
					                fileUploadIndex++;
					            }
					        }
					        geoTagFileArray.put(resultJson);
					    }
					}
					
					SportsFacilityMasterDTO.setGeotagPhotos(geoTagFileArray.toString());
				}
					
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return SportsFacilityMasterDTO;
	}


	public SportsFacilityBookingDTO setSportsFacilityBookingDTO(ResourceRequest resourceRequest,
			ThemeDisplay themeDisplay) {
		
		SportsFacilityBookingDTO SportsFacilityBookingDTO = new SportsFacilityBookingDTO();
		
		try {
			long facilityBookingId = ParamUtil.getLong(resourceRequest, "facilityBookingId");
			long selectedFacilityId = ParamUtil.getLong(resourceRequest, "selectedFacility");
			
			String dateStr = ParamUtil.getString(resourceRequest, "Date");
			Date date = null;
			if(Validator.isNotNull(dateStr)) {
				date =	 Validator.isNotNull(daterFormatter.parse(dateStr)) ? daterFormatter.parse(dateStr): null;
			}
			 
			SportsFacilityBookingDTO.setFacilityBookingId(facilityBookingId);
			SportsFacilityBookingDTO.setSelectedFacility(selectedFacilityId);
			SportsFacilityBookingDTO.setType(ParamUtil.getString(resourceRequest, "monthlyRentalRadio"));
			SportsFacilityBookingDTO.setDate(date);
			SportsFacilityBookingDTO.setBatch(ParamUtil.getString(resourceRequest, "batch"));
			SportsFacilityBookingDTO.setTimeFrom(ParamUtil.getString(resourceRequest, "timeFrom"));
			SportsFacilityBookingDTO.setTimeTo(ParamUtil.getString(resourceRequest, "timeTo"));
			SportsFacilityBookingDTO.setSportCourt(ParamUtil.getString(resourceRequest, "sportCourt"));
			SportsFacilityBookingDTO.setName(ParamUtil.getString(resourceRequest, "name"));
			SportsFacilityBookingDTO.setContact(ParamUtil.getString(resourceRequest, "contact"));
			SportsFacilityBookingDTO.setPurpose(ParamUtil.getString(resourceRequest, "purpose"));
			SportsFacilityBookingDTO.setFees(ParamUtil.getString(resourceRequest, "fees"));
			SportsFacilityBookingDTO.setNumberOfMonths(ParamUtil.getString(resourceRequest, "numberOfMonths"));
			SportsFacilityBookingDTO.setDailyOrDate(ParamUtil.getString(resourceRequest, "dailyOrDatewise"));
			SportsFacilityBookingDTO.setCreatorUserId(themeDisplay.getUserId());
			SportsFacilityBookingDTO.setModifiedDate(new Date());
			SportsFacilityBookingDTO.setBookingStatus(0);
			
			long hiddenMedicalDoc = ParamUtil.getLong(resourceRequest, "hiddenMedicalDoc");
			_log.info("hiddenMedicalDoc:: "+hiddenMedicalDoc);
			if(Validator.isNotNull(hiddenMedicalDoc) && hiddenMedicalDoc>0) {
				SportsFacilityBookingDTO.setMedicalCertificate(hiddenMedicalDoc);
			}else {
				UploadPortletRequest uploadRequest = PortalUtil.getUploadPortletRequest(resourceRequest);
				ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFileEntry.class.getName(), uploadRequest);
				File medicalCertificate = uploadRequest.getFile("medicalCertificate");
				if(Validator.isNotNull(medicalCertificate)) {
					long medicalDocFileId = fileUploadUtil.multipleFileUpload(uploadRequest, "medicalCertificate", "SportsFacilityBooking", serviceContext, medicalCertificate.getName(), medicalCertificate);
					SportsFacilityBookingDTO.setMedicalCertificate(medicalDocFileId);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return SportsFacilityBookingDTO;
	}

	public Map<Long, String> getFacilityMaster() {
	    List<SportsFacilityMaster> facilities = SportsFacilityMasterLocalServiceUtil.getSportsFacilityMasters(-1, -1);
	    Map<Long, String> map = new HashMap<>();
	    for (SportsFacilityMaster facility : facilities) {
	        map.put(facility.getSportsFacilityId(), facility.getFacilityName());
	    }
	    _log.info("getFacilityMaster =============== " + map);
	    return map;
	}


	public FacilityRatingCommonDTO setFacilityRatingDTO(ThemeDisplay themeDisplay, ResourceRequest resourceRequest) {
		
		FacilityRatingCommonDTO facilityRatingCommonDTO = new FacilityRatingCommonDTO();
		try {
			facilityRatingCommonDTO.setFacilityRatingId( ParamUtil.getLong(resourceRequest, "facilityRatingId"));
			facilityRatingCommonDTO.setFacilityMasterId(ParamUtil.getLong(resourceRequest, "facilityMasterId"));
			facilityRatingCommonDTO.setRating(ParamUtil.getString(resourceRequest, "rating"));
			facilityRatingCommonDTO.setComment(ParamUtil.getString(resourceRequest, "comment"));
			facilityRatingCommonDTO.setCreatorUserId(themeDisplay.getUserId());
			facilityRatingCommonDTO.setUserName(UserLocalServiceUtil.getUser(themeDisplay.getUserId()).getFullName());
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return facilityRatingCommonDTO;
	}


	/**
	 * @param resourceRequest
	 * @param themeDisplay
	 */
	public void saveBulkFacilities(ResourceRequest resourceRequest, ThemeDisplay themeDisplay) {
		
		String[] facilityNames = ParamUtil.getParameterValues(resourceRequest, "facilityName");
		
		int facilityLength = facilityNames != null ? facilityNames.length : 0;
	    _log.info("facilityLength:::::::: " + facilityLength);
	 
		
		if(facilityLength>1) {
			
			String[] sportsCourt = ParamUtil.getParameterValues(resourceRequest, "sportsCourt");
			String[] facilityAreas = ParamUtil.getParameterValues(resourceRequest, "facilityArea");
			String[] latitude = ParamUtil.getParameterValues(resourceRequest, "latitude");
			String[] longitude = ParamUtil.getParameterValues(resourceRequest, "longitude");
			String[] sportsName = ParamUtil.getParameterValues(resourceRequest, "sportsName");
			
			String[] division = ParamUtil.getParameterValues(resourceRequest, "division");
			String[] district = ParamUtil.getParameterValues(resourceRequest, "district");
			String[] taluka = ParamUtil.getParameterValues(resourceRequest, "taluka");
			
//			String[] typeCheckBox = ParamUtil.getParameterValues(resourceRequest, "typeCheckBox");
//			String[] fees = ParamUtil.getParameterValues(resourceRequest, "fees");

			String[] assocPerHour = ParamUtil.getParameterValues(resourceRequest, "assocPerHour");
			String[] assocPerDay = ParamUtil.getParameterValues(resourceRequest, "assocPerDay");
			String[] assocPerMonth = ParamUtil.getParameterValues(resourceRequest, "assocPerMonth");

			String[] rentOtherPerHour = ParamUtil.getParameterValues(resourceRequest, "rentOtherPerHour");
			String[] rentOtherPerDay = ParamUtil.getParameterValues(resourceRequest, "rentOtherPerDay");
			String[] rentOtherPerMonth = ParamUtil.getParameterValues(resourceRequest, "rentOtherPerMonth");

			String[] rentNonPerHour = ParamUtil.getParameterValues(resourceRequest, "rentNonPerHour");
			String[] rentNonPerDay = ParamUtil.getParameterValues(resourceRequest, "rentNonPerDay");
			String[] rentNonPerMonth = ParamUtil.getParameterValues(resourceRequest, "rentNonPerMonth");

			String[] indPerHour = ParamUtil.getParameterValues(resourceRequest, "indPerHour");
			String[] indPerDay = ParamUtil.getParameterValues(resourceRequest, "indPerDay");
			String[] indPerMonth = ParamUtil.getParameterValues(resourceRequest, "indPerMonth");

			String[] shootingPerHour = ParamUtil.getParameterValues(resourceRequest, "shootingPerHour");
			String[] shootingPerDay = ParamUtil.getParameterValues(resourceRequest, "shootingPerDay");
			String[] shootingPerMonth = ParamUtil.getParameterValues(resourceRequest, "shootingPerMonth");

			String[] lightsPerHour = ParamUtil.getParameterValues(resourceRequest, "lightsPerHour");
			String[] acPerHour = ParamUtil.getParameterValues(resourceRequest, "acPerHour");
			
			// Using getParameterValues for all fields
			String[] facilityType = ParamUtil.getParameterValues(resourceRequest, "facilityType");
			String[] contactPersonEmail = ParamUtil.getParameterValues(resourceRequest, "contactPersonEmail");
			String[] city = ParamUtil.getParameterValues(resourceRequest, "city");
			String[] address = ParamUtil.getParameterValues(resourceRequest, "address");
			String[] mainTypeOfFacility = ParamUtil.getParameterValues(resourceRequest, "mainTypeOfFacility");
			String[] courtNameNumber = ParamUtil.getParameterValues(resourceRequest, "courtNameNumber");
			String[] availableFacilities = ParamUtil.getParameterValues(resourceRequest, "availableFacilities");
			String[] notWorkingReason = ParamUtil.getParameterValues(resourceRequest, "notWorkingReason");
			String[] capacity = ParamUtil.getParameterValues(resourceRequest, "capacity");
			String[] remarks = ParamUtil.getParameterValues(resourceRequest, "remarks");
            _log.info("availableFacilities::::::::::::::"+Arrays.toString(notWorkingReason));
            
			for (int i = 0; i < facilityLength; i++) {
				SportsFacilityMaster sportsFacilityMaster = SportsFacilityMasterLocalServiceUtil
						.createSportsFacilityMaster(CounterLocalServiceUtil.increment(SportsFacilityMaster.class.getName()));

				sportsFacilityMaster.setFacilityName(facilityNames[i]);
				sportsFacilityMaster.setSportsCourt(sportsCourt[i]);
				sportsFacilityMaster.setFacilityArea(facilityAreas[i]);
				sportsFacilityMaster.setSportsName(sportsName[i]);
				sportsFacilityMaster.setLatitude(latitude[i]);
				sportsFacilityMaster.setLongitude(longitude[i]);
//				sportsFacilityMaster.setType(typeCheckBox[i]);
//				sportsFacilityMaster.setFees(fees[i]);
				sportsFacilityMaster.setIsUpdatedByHO(true);
				sportsFacilityMaster.setCreatorUserId(themeDisplay.getUserId());
				sportsFacilityMaster.setCreateDate(new Date());
				sportsFacilityMaster.setModifiedDate(new Date());
				
				sportsFacilityMaster.setFacilityLocation("Shiv Chhtrapati Sports Complex");
				
				sportsFacilityMaster.setDivision(parseLongSafe(division[i]));
				sportsFacilityMaster.setDistrict(parseLongSafe(district[i]));
				sportsFacilityMaster.setTaluka(parseLongSafe(taluka[i]));

		        sportsFacilityMaster.setAssoc_fed_perHour(parseDoubleSafe(assocPerHour[i]));
		        sportsFacilityMaster.setAssoc_fed_perDay(parseDoubleSafe(assocPerDay[i]));
		        sportsFacilityMaster.setAssoc_fed_perMonth(parseDoubleSafe(assocPerMonth[i]));

		        sportsFacilityMaster.setRent_other_sports_perHour(parseDoubleSafe(rentOtherPerHour[i]));
		        sportsFacilityMaster.setRent_other_sports_perDay(parseDoubleSafe(rentOtherPerDay[i]));
		        sportsFacilityMaster.setRent_other_sports_perMonth(parseDoubleSafe(rentOtherPerMonth[i]));

		        sportsFacilityMaster.setRent_nonsports_perHour(parseDoubleSafe(rentNonPerHour[i]));
		        sportsFacilityMaster.setRent_nonsports_perDay(parseDoubleSafe(rentNonPerDay[i]));
		        sportsFacilityMaster.setRent_nonsports_perMonth(parseDoubleSafe(rentNonPerMonth[i]));

		        sportsFacilityMaster.setIndividual_perHour(parseDoubleSafe(indPerHour[i]));
		        sportsFacilityMaster.setIndividual_perDay(parseDoubleSafe(indPerDay[i]));
		        sportsFacilityMaster.setIndividual_perMonth(parseDoubleSafe(indPerMonth[i]));

		        sportsFacilityMaster.setShooting_rapid_perHour(parseDoubleSafe(shootingPerHour[i]));
		        sportsFacilityMaster.setShooting_rapid_perDay(parseDoubleSafe(shootingPerDay[i]));
		        sportsFacilityMaster.setShooting_rapid_perMonth(parseDoubleSafe(shootingPerMonth[i]));

//		        sportsFacilityMaster.setFireArm(fireArm[i]);
//		        sportsFacilityMaster.setAmmunition_license(ammunitionLicense[i]);

		        sportsFacilityMaster.setArena_lights_perHour(parseDoubleSafe(lightsPerHour[i]));
		        sportsFacilityMaster.setAc_perHour(parseDoubleSafe(acPerHour[i]));
		        
		        
		        sportsFacilityMaster.setFacilityType(parseStringSafe(facilityType[i]));
		        sportsFacilityMaster.setContactPersonEmail(parseStringSafe(contactPersonEmail[i]));
		        sportsFacilityMaster.setCity(parseStringSafe(city[i]));
		        sportsFacilityMaster.setAddress(parseStringSafe(address[i]));
		        sportsFacilityMaster.setMainTypeOfFacility(parseStringSafe(mainTypeOfFacility[i]));
		        sportsFacilityMaster.setCourtNameNumber(parseStringSafe(courtNameNumber[i]));
		        sportsFacilityMaster.setAvailableFacilities(parseStringSafe(availableFacilities[i]));

		        // Only set Not Working Reason if availableFacilities = "Not Working"
		        if ("Not Working".equalsIgnoreCase(availableFacilities[i])) {
		            sportsFacilityMaster.setNotWorkingReason(parseStringSafe(notWorkingReason[i]));
		        } else {
		            sportsFacilityMaster.setNotWorkingReason(null);
		        }

		        sportsFacilityMaster.setCapacity(parseStringSafe(capacity[i]));
		        sportsFacilityMaster.setRemarks(parseStringSafe(remarks[i]));
		        
		        _log.info("sportsFacilityMaster::::::::::"+sportsFacilityMaster);

		        
		        SportsFacilityMasterLocalServiceUtil.addSportsFacilityMaster(sportsFacilityMaster);
		        _log.info("Saved sportsFacilityMaster Id::: "+ sportsFacilityMaster.getSportsFacilityId());
			}
		}else if (facilityLength == 1) {
			SportsFacilityMasterDTO SportsFacilityMasterDTO = setSportsFacilityMasterDTO(resourceRequest,themeDisplay);
			SportsFacilityMaster sportsFacilityMasterModal = _SportsFacilityMasterCommonApi.saveSportsFacilityMaster(SportsFacilityMasterDTO);
		}
		
	}
	
	private String parseStringSafe(String value) {
	    return value != null ? value.trim() : "";
	}
	
	private double parseDoubleSafe(String value) {
	    if (value == null || value.isEmpty()) return 0;
	    try {
	        return Double.parseDouble(value);
	    } catch (NumberFormatException e) {
	        return 0;
	    }
	}

	private long parseLongSafe(String value) {
	    if (value == null || value.isEmpty()) return 0;
	    try {
	        return Long.parseLong(value);
	    } catch (NumberFormatException e) {
	        return 0;
	    }
	}
	
	public Map<String, String> getDivisionMap(List<DivisionMaster> divisions) {
	    Map<String, String> map = new HashMap<>();
	    for (DivisionMaster division : divisions) {
	        map.put(String.valueOf(division.getDivisionId()), division.getDivisionName_en());
	    }
//	    LOGGER.info("getDivisionMap::::: "+map);
	    return map;
	}

	public Map<String, String> getDistrictMap(List<DistrictMaster> districts) {
	    Map<String, String> map = new HashMap<>();
	    for (DistrictMaster district : districts) {
	        map.put(String.valueOf(district.getDistrictId()), district.getDistrictName_en());
	    }
//	    LOGGER.info("getDistrictMap::::: "+map);
	    return map;
	}

	public Map<String, String> getTalukaMap(List<TalukaMaster> talukas) {
	    Map<String, String> map = new HashMap<>();
	    for (TalukaMaster taluka : talukas) {
	        map.put(String.valueOf(taluka.getTalukaId()), taluka.getTalukaName_en());
	    }
//	    LOGGER.info("getDistrictMap::::: "+map);
	    return map;
	}
	
	@Reference private SportsFacilityMasterCommonApi _SportsFacilityMasterCommonApi;
	
}
