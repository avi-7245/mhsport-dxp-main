package com.mhdsys.common.pojo;

import java.util.Date;

public class SportsFacilityMasterDTO {

	private long sportsFacilityId;
	private String facilityName;
	private String facilityType;
	private String facilityArea;
	private String longitude;
	private String latitude;
	private String geotagPhotos;
	private String type;
	private String fees;
	private String bookingUrl;
	private String contactPersonName;
	private String contactPersonNumber;

	private long creatorUserId;
	private long modifierUserId;

	private Date createDate;
	private Date modifiedDate;
	
	private boolean isUpdatedByHO;
	private boolean isUpdatedByDSO;
	private boolean isUpdatedByDDD;
	
	private boolean hoAction;
	
	 // --- New Fields (now matching entity names) ---
    private String facilityLocation;
    private String sportsName;
    private long division;
    private long district;
    private long taluka;
    private String timeSlot;

    private double assoc_fed_perHour;
    private double assoc_fed_perDay;
    private double assoc_fed_perMonth;

    private double rent_other_sports_perHour;
    private double rent_other_sports_perDay;
    private double rent_other_sports_perMonth;

    private double rent_nonsports_perHour;
    private double rent_nonsports_perDay;
    private double rent_nonsports_perMonth;

    private double individual_perHour;
    private double individual_perDay;
    private double individual_perMonth;

    private double shooting_rapid_perHour;
    private double shooting_rapid_perDay;
    private double shooting_rapid_perMonth;

    private String fireArm;
    private String ammunition_license;

    private double arena_lights_perHour;
    private double ac_perHour;
    
    private String sportsCourt;
	private String contactPersonEmail;
	private String city;
	private String address;
	private String mainTypeOfFacility;
	private String courtNameNumber;
	private String availableFacilities;
	private String notWorkingReason;
	private String capacity;
	private String remarks;
    
	
	public boolean isHoAction() {
		return hoAction;
	}
	public void setHoAction(boolean hoAction) {
		this.hoAction = hoAction;
	}
	
	public long getSportsFacilityId() {
		return sportsFacilityId;
	}
	public void setSportsFacilityId(long sportsFacilityId) {
		this.sportsFacilityId = sportsFacilityId;
	}
	public String getFacilityName() {
		return facilityName;
	}
	public void setFacilityName(String facilityName) {
		this.facilityName = facilityName;
	}
	public String getFacilityType() {
		return facilityType;
	}
	public void setFacilityType(String facilityType) {
		this.facilityType = facilityType;
	}
	public String getFacilityArea() {
		return facilityArea;
	}
	public void setFacilityArea(String facilityArea) {
		this.facilityArea = facilityArea;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getGeotagPhotos() {
		return geotagPhotos;
	}
	public void setGeotagPhotos(String geotagPhotos) {
		this.geotagPhotos = geotagPhotos;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFees() {
		return fees;
	}
	public void setFees(String fees) {
		this.fees = fees;
	}
	public String getBookingUrl() {
		return bookingUrl;
	}
	public void setBookingUrl(String bookingUrl) {
		this.bookingUrl = bookingUrl;
	}
	public String getContactPersonName() {
		return contactPersonName;
	}
	public void setContactPersonName(String contactPersonName) {
		this.contactPersonName = contactPersonName;
	}
	public String getContactPersonNumber() {
		return contactPersonNumber;
	}
	public void setContactPersonNumber(String contactPersonNumber) {
		this.contactPersonNumber = contactPersonNumber;
	}
	public long getCreatorUserId() {
		return creatorUserId;
	}
	public void setCreatorUserId(long creatorUserId) {
		this.creatorUserId = creatorUserId;
	}
	public long getModifierUserId() {
		return modifierUserId;
	}
	public void setModifierUserId(long modifierUserId) {
		this.modifierUserId = modifierUserId;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getModifiedDate() {
		return modifiedDate;
	}
	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	public boolean getIsUpdatedByHO() {
		return isUpdatedByHO;
	}
	public void setIsUpdatedByHO(boolean isUpdatedByHO) {
		this.isUpdatedByHO = isUpdatedByHO;
	}
	public boolean getIsUpdatedByDSO() {
		return isUpdatedByDSO;
	}
	public void setIsUpdatedByDSO(boolean isUpdatedByDSO) {
		this.isUpdatedByDSO = isUpdatedByDSO;
	}
	public boolean getIsUpdatedByDDD() {
		return isUpdatedByDDD;
	}
	public void setIsUpdatedByDDD(boolean isUpdatedByDDD) {
		this.isUpdatedByDDD = isUpdatedByDDD;
	}
	public String getFacilityLocation() {
		return facilityLocation;
	}
	public void setFacilityLocation(String facilityLocation) {
		this.facilityLocation = facilityLocation;
	}
	public long getDivision() {
		return division;
	}
	public void setDivision(long division) {
		this.division = division;
	}
	public long getDistrict() {
		return district;
	}
	public void setDistrict(long district) {
		this.district = district;
	}
	public long getTaluka() {
		return taluka;
	}
	public void setTaluka(long taluka) {
		this.taluka = taluka;
	}
	public String getTimeSlot() {
		return timeSlot;
	}
	public void setTimeSlot(String timeSlot) {
		this.timeSlot = timeSlot;
	}
	public double getAssoc_fed_perHour() {
		return assoc_fed_perHour;
	}
	public void setAssoc_fed_perHour(double assoc_fed_perHour) {
		this.assoc_fed_perHour = assoc_fed_perHour;
	}
	public double getAssoc_fed_perDay() {
		return assoc_fed_perDay;
	}
	public void setAssoc_fed_perDay(double assoc_fed_perDay) {
		this.assoc_fed_perDay = assoc_fed_perDay;
	}
	public double getAssoc_fed_perMonth() {
		return assoc_fed_perMonth;
	}
	public void setAssoc_fed_perMonth(double assoc_fed_perMonth) {
		this.assoc_fed_perMonth = assoc_fed_perMonth;
	}
	public double getRent_other_sports_perHour() {
		return rent_other_sports_perHour;
	}
	public void setRent_other_sports_perHour(double rent_other_sports_perHour) {
		this.rent_other_sports_perHour = rent_other_sports_perHour;
	}
	public double getRent_other_sports_perDay() {
		return rent_other_sports_perDay;
	}
	public void setRent_other_sports_perDay(double rent_other_sports_perDay) {
		this.rent_other_sports_perDay = rent_other_sports_perDay;
	}
	public double getRent_other_sports_perMonth() {
		return rent_other_sports_perMonth;
	}
	public void setRent_other_sports_perMonth(double rent_other_sports_perMonth) {
		this.rent_other_sports_perMonth = rent_other_sports_perMonth;
	}
	public double getRent_nonsports_perHour() {
		return rent_nonsports_perHour;
	}
	public void setRent_nonsports_perHour(double rent_nonsports_perHour) {
		this.rent_nonsports_perHour = rent_nonsports_perHour;
	}
	public double getRent_nonsports_perDay() {
		return rent_nonsports_perDay;
	}
	public void setRent_nonsports_perDay(double rent_nonsports_perDay) {
		this.rent_nonsports_perDay = rent_nonsports_perDay;
	}
	public double getRent_nonsports_perMonth() {
		return rent_nonsports_perMonth;
	}
	public void setRent_nonsports_perMonth(double rent_nonsports_perMonth) {
		this.rent_nonsports_perMonth = rent_nonsports_perMonth;
	}
	public double getIndividual_perHour() {
		return individual_perHour;
	}
	public void setIndividual_perHour(double individual_perHour) {
		this.individual_perHour = individual_perHour;
	}
	public double getIndividual_perDay() {
		return individual_perDay;
	}
	public void setIndividual_perDay(double individual_perDay) {
		this.individual_perDay = individual_perDay;
	}
	public double getIndividual_perMonth() {
		return individual_perMonth;
	}
	public void setIndividual_perMonth(double individual_perMonth) {
		this.individual_perMonth = individual_perMonth;
	}
	public double getShooting_rapid_perHour() {
		return shooting_rapid_perHour;
	}
	public void setShooting_rapid_perHour(double shooting_rapid_perHour) {
		this.shooting_rapid_perHour = shooting_rapid_perHour;
	}
	public double getShooting_rapid_perDay() {
		return shooting_rapid_perDay;
	}
	public void setShooting_rapid_perDay(double shooting_rapid_perDay) {
		this.shooting_rapid_perDay = shooting_rapid_perDay;
	}
	public double getShooting_rapid_perMonth() {
		return shooting_rapid_perMonth;
	}
	public void setShooting_rapid_perMonth(double shooting_rapid_perMonth) {
		this.shooting_rapid_perMonth = shooting_rapid_perMonth;
	}
	public String getFireArm() {
		return fireArm;
	}
	public void setFireArm(String fireArm) {
		this.fireArm = fireArm;
	}
	public String getAmmunition_license() {
		return ammunition_license;
	}
	public void setAmmunition_license(String ammunition_license) {
		this.ammunition_license = ammunition_license;
	}
	public double getArena_lights_perHour() {
		return arena_lights_perHour;
	}
	public void setArena_lights_perHour(double arena_lights_perHour) {
		this.arena_lights_perHour = arena_lights_perHour;
	}
	public double getAc_perHour() {
		return ac_perHour;
	}
	public void setAc_perHour(double ac_perHour) {
		this.ac_perHour = ac_perHour;
	}
	public void setUpdatedByHO(boolean isUpdatedByHO) {
		this.isUpdatedByHO = isUpdatedByHO;
	}
	public void setUpdatedByDSO(boolean isUpdatedByDSO) {
		this.isUpdatedByDSO = isUpdatedByDSO;
	}
	public String getSportsName() {
		return sportsName;
	}
	public void setSportsName(String sportsName) {
		this.sportsName = sportsName;
	}
	
	public String getSportsCourt() {
		return sportsCourt;
	}
	public void setSportsCourt(String sportsCourt) {
		this.sportsCourt = sportsCourt;
	}
	public String getContactPersonEmail() {
		return contactPersonEmail;
	}
	public void setContactPersonEmail(String contactPersonEmail) {
		this.contactPersonEmail = contactPersonEmail;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getMainTypeOfFacility() {
		return mainTypeOfFacility;
	}
	public void setMainTypeOfFacility(String mainTypeOfFacility) {
		this.mainTypeOfFacility = mainTypeOfFacility;
	}
	public String getCourtNameNumber() {
		return courtNameNumber;
	}
	public void setCourtNameNumber(String courtNameNumber) {
		this.courtNameNumber = courtNameNumber;
	}
	public String getAvailableFacilities() {
		return availableFacilities;
	}
	public void setAvailableFacilities(String availableFacilities) {
		this.availableFacilities = availableFacilities;
	}
	public String getNotWorkingReason() {
		return notWorkingReason;
	}
	public void setNotWorkingReason(String notWorkingReason) {
		this.notWorkingReason = notWorkingReason;
	}
	public String getCapacity() {
		return capacity;
	}
	public void setCapacity(String capacity) {
		this.capacity = capacity;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	@Override
	public String toString() {
		return "SportsFacilityMasterDTO [sportsFacilityId=" + sportsFacilityId + ", facilityName=" + facilityName
				+ ", facilityType=" + facilityType + ", facilityArea=" + facilityArea + ", longitude=" + longitude
				+ ", latitude=" + latitude + ", geotagPhotos=" + geotagPhotos + ", type=" + type + ", fees=" + fees
				+ ", bookingUrl=" + bookingUrl + ", contactPersonName=" + contactPersonName + ", contactPersonNumber="
				+ contactPersonNumber + ", creatorUserId=" + creatorUserId + ", modifierUserId=" + modifierUserId
				+ ", createDate=" + createDate + ", modifiedDate=" + modifiedDate + ", isUpdatedByHO=" + isUpdatedByHO
				+ ", isUpdatedByDSO=" + isUpdatedByDSO + ", isUpdatedByDDD=" + isUpdatedByDDD + ", hoAction=" + hoAction
				+ ", facilityLocation=" + facilityLocation + ", sportsName=" + sportsName + ", division=" + division
				+ ", district=" + district + ", taluka=" + taluka + ", timeSlot=" + timeSlot + ", assoc_fed_perHour="
				+ assoc_fed_perHour + ", assoc_fed_perDay=" + assoc_fed_perDay + ", assoc_fed_perMonth="
				+ assoc_fed_perMonth + ", rent_other_sports_perHour=" + rent_other_sports_perHour
				+ ", rent_other_sports_perDay=" + rent_other_sports_perDay + ", rent_other_sports_perMonth="
				+ rent_other_sports_perMonth + ", rent_nonsports_perHour=" + rent_nonsports_perHour
				+ ", rent_nonsports_perDay=" + rent_nonsports_perDay + ", rent_nonsports_perMonth="
				+ rent_nonsports_perMonth + ", individual_perHour=" + individual_perHour + ", individual_perDay="
				+ individual_perDay + ", individual_perMonth=" + individual_perMonth + ", shooting_rapid_perHour="
				+ shooting_rapid_perHour + ", shooting_rapid_perDay=" + shooting_rapid_perDay
				+ ", shooting_rapid_perMonth=" + shooting_rapid_perMonth + ", fireArm=" + fireArm
				+ ", ammunition_license=" + ammunition_license + ", arena_lights_perHour=" + arena_lights_perHour
				+ ", ac_perHour=" + ac_perHour + ", sportsCourt=" + sportsCourt + ", contactPersonEmail="
				+ contactPersonEmail + ", city=" + city + ", address=" + address + ", mainTypeOfFacility="
				+ mainTypeOfFacility + ", courtNameNumber=" + courtNameNumber + ", availableFacilities="
				+ availableFacilities + ", notWorkingReason=" + notWorkingReason + ", capacity=" + capacity
				+ ", remarks=" + remarks + "]";
	}
	


}
