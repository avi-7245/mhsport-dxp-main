package com.mhdsys.common.pojo;

import java.util.Date;

public class AthleteSportsCertificateDTO {

	private long athleteCertificateId;

	private long userId;
	private long groupId;
	private long companyId;

	private Date createDate;
	private String createDateStr;

	private Date modifiedDate;
	private String modifiedDateStr;

	private String sportsPersonName;
	private String guardianName;

	private String dateOfBirth;
	private String dateOfBirthStr;

	private String residentDistrict;
	private String representing;
	private String gameName;

	private String competitionName;
	private String competitionVenue;

	private Date competitionFromDate;
	private String competitionFromDateStr;

	private Date competitionToDate;
	private String competitionToDateStr;

	private String competitionLevel;
	private String positionObtained;
	private String certificateNo;

	private int status;
	private long statusByUserId;
	private String statusByUserName;

	private Date statusDate;
	private String statusDateStr;

	private String gender;
	private String gameCode;
	private String ageCode;
	private String genderCode;

	public long getAthleteCertificateId() {
		return athleteCertificateId;
	}

	public void setAthleteCertificateId(long athleteCertificateId) {
		this.athleteCertificateId = athleteCertificateId;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}

	public long getGroupId() {
		return groupId;
	}

	public void setGroupId(long groupId) {
		this.groupId = groupId;
	}

	public long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getCreateDateStr() {
		return createDateStr;
	}

	public void setCreateDateStr(String createDateStr) {
		this.createDateStr = createDateStr;
	}

	public Date getModifiedDate() {
		return modifiedDate;
	}

	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}

	public String getModifiedDateStr() {
		return modifiedDateStr;
	}

	public void setModifiedDateStr(String modifiedDateStr) {
		this.modifiedDateStr = modifiedDateStr;
	}

	public String getSportsPersonName() {
		return sportsPersonName;
	}

	public void setSportsPersonName(String sportsPersonName) {
		this.sportsPersonName = sportsPersonName;
	}

	public String getGuardianName() {
		return guardianName;
	}

	public void setGuardianName(String guardianName) {
		this.guardianName = guardianName;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getDateOfBirthStr() {
		return dateOfBirthStr;
	}

	public void setDateOfBirthStr(String dateOfBirthStr) {
		this.dateOfBirthStr = dateOfBirthStr;
	}

	public String getResidentDistrict() {
		return residentDistrict;
	}

	public void setResidentDistrict(String residentDistrict) {
		this.residentDistrict = residentDistrict;
	}

	public String getRepresenting() {
		return representing;
	}

	public void setRepresenting(String representing) {
		this.representing = representing;
	}

	public String getGameName() {
		return gameName;
	}

	public void setGameName(String gameName) {
		this.gameName = gameName;
	}

	public String getCompetitionName() {
		return competitionName;
	}

	public void setCompetitionName(String competitionName) {
		this.competitionName = competitionName;
	}

	public String getCompetitionVenue() {
		return competitionVenue;
	}

	public void setCompetitionVenue(String competitionVenue) {
		this.competitionVenue = competitionVenue;
	}

	public Date getCompetitionFromDate() {
		return competitionFromDate;
	}

	public void setCompetitionFromDate(Date competitionFromDate) {
		this.competitionFromDate = competitionFromDate;
	}

	public String getCompetitionFromDateStr() {
		return competitionFromDateStr;
	}

	public void setCompetitionFromDateStr(String competitionFromDateStr) {
		this.competitionFromDateStr = competitionFromDateStr;
	}

	public Date getCompetitionToDate() {
		return competitionToDate;
	}

	public void setCompetitionToDate(Date competitionToDate) {
		this.competitionToDate = competitionToDate;
	}

	public String getCompetitionToDateStr() {
		return competitionToDateStr;
	}

	public void setCompetitionToDateStr(String competitionToDateStr) {
		this.competitionToDateStr = competitionToDateStr;
	}

	public String getCompetitionLevel() {
		return competitionLevel;
	}

	public void setCompetitionLevel(String competitionLevel) {
		this.competitionLevel = competitionLevel;
	}

	public String getPositionObtained() {
		return positionObtained;
	}

	public void setPositionObtained(String positionObtained) {
		this.positionObtained = positionObtained;
	}

	public String getCertificateNo() {
		return certificateNo;
	}

	public void setCertificateNo(String certificateNo) {
		this.certificateNo = certificateNo;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public long getStatusByUserId() {
		return statusByUserId;
	}

	public void setStatusByUserId(long statusByUserId) {
		this.statusByUserId = statusByUserId;
	}

	public String getStatusByUserName() {
		return statusByUserName;
	}

	public void setStatusByUserName(String statusByUserName) {
		this.statusByUserName = statusByUserName;
	}

	public Date getStatusDate() {
		return statusDate;
	}

	public void setStatusDate(Date statusDate) {
		this.statusDate = statusDate;
	}

	public String getStatusDateStr() {
		return statusDateStr;
	}

	public void setStatusDateStr(String statusDateStr) {
		this.statusDateStr = statusDateStr;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getGameCode() {
		return gameCode;
	}

	public void setGameCode(String gameCode) {
		this.gameCode = gameCode;
	}

	public String getAgeCode() {
		return ageCode;
	}

	public void setAgeCode(String ageCode) {
		this.ageCode = ageCode;
	}

	public String getGenderCode() {
		return genderCode;
	}

	public void setGenderCode(String genderCode) {
		this.genderCode = genderCode;
	}

	@Override
	public String toString() {
		return "AthleteSportsCertificateDTO [athleteCertificateId=" + athleteCertificateId + ", userId=" + userId
				+ ", groupId=" + groupId + ", companyId=" + companyId + ", createDate=" + createDate
				+ ", createDateStr=" + createDateStr + ", modifiedDate=" + modifiedDate + ", modifiedDateStr="
				+ modifiedDateStr + ", sportsPersonName=" + sportsPersonName + ", guardianName=" + guardianName
				+ ", dateOfBirth=" + dateOfBirth + ", dateOfBirthStr=" + dateOfBirthStr + ", residentDistrict="
				+ residentDistrict + ", representing=" + representing + ", gameName=" + gameName + ", competitionName="
				+ competitionName + ", competitionVenue=" + competitionVenue + ", competitionFromDate="
				+ competitionFromDate + ", competitionFromDateStr=" + competitionFromDateStr + ", competitionToDate="
				+ competitionToDate + ", competitionToDateStr=" + competitionToDateStr + ", competitionLevel="
				+ competitionLevel + ", positionObtained=" + positionObtained + ", certificateNo=" + certificateNo
				+ ", status=" + status + ", statusByUserId=" + statusByUserId + ", statusByUserName=" + statusByUserName
				+ ", statusDate=" + statusDate + ", statusDateStr=" + statusDateStr + ", gender=" + gender
				+ ", gameCode=" + gameCode + ", ageCode=" + ageCode + ", genderCode=" + genderCode + "]";
	}

}
