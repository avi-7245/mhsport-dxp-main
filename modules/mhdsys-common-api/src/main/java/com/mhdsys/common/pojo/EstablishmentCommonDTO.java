package com.mhdsys.common.pojo;

import java.util.Date;

public class EstablishmentCommonDTO {
	private long establishmentDetailId;
	private boolean personalDetails;
	private boolean serviceDetails;
	private boolean trainingDetails;
	private boolean npsDetails;
	private boolean gpfDetails;
	private boolean postingStatus;
	private boolean roasterStatus;

	private long userId;
	private Date createDate;
	private Date modifiedDate;
	private String createDateStr;
	private String modifiedDateStr;

	private String employeeName;
	private String employeeRole;

	private String sevarathId;
	private String education;
	private String hometown;

	public long getEstablishmentDetailId() {
		return establishmentDetailId;
	}

	public void setEstablishmentDetailId(long establishmentDetailId) {
		this.establishmentDetailId = establishmentDetailId;
	}

	public boolean isPersonalDetails() {
		return personalDetails;
	}

	public void setPersonalDetails(boolean personalDetails) {
		this.personalDetails = personalDetails;
	}

	public boolean isServiceDetails() {
		return serviceDetails;
	}

	public void setServiceDetails(boolean serviceDetails) {
		this.serviceDetails = serviceDetails;
	}

	public boolean isTrainingDetails() {
		return trainingDetails;
	}

	public void setTrainingDetails(boolean trainingDetails) {
		this.trainingDetails = trainingDetails;
	}

	public boolean isNpsDetails() {
		return npsDetails;
	}

	public void setNpsDetails(boolean npsDetails) {
		this.npsDetails = npsDetails;
	}

	public boolean isGpfDetails() {
		return gpfDetails;
	}

	public void setGpfDetails(boolean gpfDetails) {
		this.gpfDetails = gpfDetails;
	}

	public boolean isPostingStatus() {
		return postingStatus;
	}

	public void setPostingStatus(boolean postingStatus) {
		this.postingStatus = postingStatus;
	}

	public boolean isRoasterStatus() {
		return roasterStatus;
	}

	public void setRoasterStatus(boolean roasterStatus) {
		this.roasterStatus = roasterStatus;
	}

	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
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

	public String getEmployeeName() {
		return employeeName;
	}

	public void setEmployeeName(String employeeName) {
		this.employeeName = employeeName;
	}

	public String getEmployeeRole() {
		return employeeRole;
	}

	public void setEmployeeRole(String employeeRole) {
		this.employeeRole = employeeRole;
	}

	public String getSevarathId() {
		return sevarathId;
	}

	public void setSevarathId(String sevarathId) {
		this.sevarathId = sevarathId;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getHometown() {
		return hometown;
	}

	public void setHometown(String hometown) {
		this.hometown = hometown;
	}

	@Override
	public String toString() {
		return "EstablishmentCommonDTO [establishmentDetailId=" + establishmentDetailId + ", personalDetails="
				+ personalDetails + ", serviceDetails=" + serviceDetails + ", trainingDetails=" + trainingDetails
				+ ", npsDetails=" + npsDetails + ", gpfDetails=" + gpfDetails + ", postingStatus=" + postingStatus
				+ ", roasterStatus=" + roasterStatus + ", userId=" + userId + ", createDate=" + createDate
				+ ", modifiedDate=" + modifiedDate + ", createDateStr=" + createDateStr + ", modifiedDateStr="
				+ modifiedDateStr + ", employeeName=" + employeeName + ", employeeRole=" + employeeRole
				+ ", sevarathId=" + sevarathId + ", education=" + education + ", hometown=" + hometown + "]";
	}

}
