package com.mhdsys.common.pojo;

import java.util.Date;

public class CompetitionInitiationCommonDTO {
	private long competitionInitiationId;
	private long competitionMasterId;
	private long sportId;
	private long taluka;
	private long categoryId;
	private String underForteen;
	private String underSeventeen;
	private String underNineteen;
	private Date competitionStartDate;
	private Date competitionEndDate;
	private double fees;
	private double affiliationFeesByTotalCount;
	private double affiliationFeesByCategory;
	private boolean selfDeclaration;
	private String venueDetails;
	private Date createDate;
	private Date modifiedDate;
	private long userId;
	private int districtOrTaluka;

//		Manupulation

	private String sportType;
	private String sportName;
	private String categoryName;
	private String createDateStr;
	private String modifiedDateStr;
	private String competitionStartDateStr;
	private String competitionEndDateStr;
	private String districtOrTalukaName;

	public long getCompetitionInitiationId() {
		return competitionInitiationId;
	}

	public void setCompetitionInitiationId(long competitionInitiationId) {
		this.competitionInitiationId = competitionInitiationId;
	}

	public long getCompetitionMasterId() {
		return competitionMasterId;
	}

	public void setCompetitionMasterId(long competitionMasterId) {
		this.competitionMasterId = competitionMasterId;
	}

	public long getSportId() {
		return sportId;
	}

	public void setSportId(long sportId) {
		this.sportId = sportId;
	}

	public long getTaluka() {
		return taluka;
	}

	public void setTaluka(long taluka) {
		this.taluka = taluka;
	}

	public long getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(long categoryId) {
		this.categoryId = categoryId;
	}

	public String getUnderForteen() {
		return underForteen;
	}

	public void setUnderForteen(String underForteen) {
		this.underForteen = underForteen;
	}

	public String getUnderSeventeen() {
		return underSeventeen;
	}

	public void setUnderSeventeen(String underSeventeen) {
		this.underSeventeen = underSeventeen;
	}

	public String getUnderNineteen() {
		return underNineteen;
	}

	public void setUnderNineteen(String underNineteen) {
		this.underNineteen = underNineteen;
	}

	public Date getCompetitionStartDate() {
		return competitionStartDate;
	}

	public void setCompetitionStartDate(Date competitionStartDate) {
		this.competitionStartDate = competitionStartDate;
	}

	public Date getCompetitionEndDate() {
		return competitionEndDate;
	}

	public void setCompetitionEndDate(Date competitionEndDate) {
		this.competitionEndDate = competitionEndDate;
	}

	public double getFees() {
		return fees;
	}

	public void setFees(double fees) {
		this.fees = fees;
	}

	public double getAffiliationFeesByTotalCount() {
		return affiliationFeesByTotalCount;
	}

	public void setAffiliationFeesByTotalCount(double affiliationFeesByTotalCount) {
		this.affiliationFeesByTotalCount = affiliationFeesByTotalCount;
	}

	public double getAffiliationFeesByCategory() {
		return affiliationFeesByCategory;
	}

	public void setAffiliationFeesByCategory(double affiliationFeesByCategory) {
		this.affiliationFeesByCategory = affiliationFeesByCategory;
	}

	public boolean isSelfDeclaration() {
		return selfDeclaration;
	}

	public void setSelfDeclaration(boolean selfDeclaration) {
		this.selfDeclaration = selfDeclaration;
	}

	public String getVenueDetails() {
		return venueDetails;
	}

	public void setVenueDetails(String venueDetails) {
		this.venueDetails = venueDetails;
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

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public int getDistrictOrTaluka() {
		return districtOrTaluka;
	}

	public void setDistrictOrTaluka(int districtOrTaluka) {
		this.districtOrTaluka = districtOrTaluka;
	}

	public String getSportType() {
		return sportType;
	}

	public void setSportType(String sportType) {
		this.sportType = sportType;
	}

	public String getSportName() {
		return sportName;
	}

	public void setSportName(String sportName) {
		this.sportName = sportName;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getCreateDateStr() {
		return createDateStr;
	}

	public void setCreateDateStr(String createDateStr) {
		this.createDateStr = createDateStr;
	}

	public String getModifiedDateStr() {
		return modifiedDateStr;
	}

	public void setModifiedDateStr(String modifiedDateStr) {
		this.modifiedDateStr = modifiedDateStr;
	}

	public String getCompetitionStartDateStr() {
		return competitionStartDateStr;
	}

	public void setCompetitionStartDateStr(String competitionStartDateStr) {
		this.competitionStartDateStr = competitionStartDateStr;
	}

	public String getCompetitionEndDateStr() {
		return competitionEndDateStr;
	}

	public void setCompetitionEndDateStr(String competitionEndDateStr) {
		this.competitionEndDateStr = competitionEndDateStr;
	}

	public String getDistrictOrTalukaName() {
		return districtOrTalukaName;
	}

	public void setDistrictOrTalukaName(String districtOrTalukaName) {
		this.districtOrTalukaName = districtOrTalukaName;
	}

	@Override
	public String toString() {
		return "CompetitionInitiationCommonDTO [competitionInitiationId=" + competitionInitiationId
				+ ", competitionMasterId=" + competitionMasterId + ", sportId=" + sportId + ", taluka=" + taluka
				+ ", categoryId=" + categoryId + ", underForteen=" + underForteen + ", underSeventeen=" + underSeventeen
				+ ", underNineteen=" + underNineteen + ", competitionStartDate=" + competitionStartDate
				+ ", competitionEndDate=" + competitionEndDate + ", fees=" + fees + ", affiliationFeesByTotalCount="
				+ affiliationFeesByTotalCount + ", affiliationFeesByCategory=" + affiliationFeesByCategory
				+ ", selfDeclaration=" + selfDeclaration + ", venueDetails=" + venueDetails + ", createDate="
				+ createDate + ", modifiedDate=" + modifiedDate + ", userId=" + userId + ", districtOrTaluka="
				+ districtOrTaluka + ", sportType=" + sportType + ", sportName=" + sportName + ", categoryName="
				+ categoryName + ", createDateStr=" + createDateStr + ", modifiedDateStr=" + modifiedDateStr
				+ ", competitionStartDateStr=" + competitionStartDateStr + ", competitionEndDateStr="
				+ competitionEndDateStr + ", districtOrTalukaName=" + districtOrTalukaName + "]";
	}

}
