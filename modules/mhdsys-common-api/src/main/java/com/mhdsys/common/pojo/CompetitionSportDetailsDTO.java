package com.mhdsys.common.pojo;

import java.util.Date;

public class CompetitionSportDetailsDTO {

	private long sportDetailId;
	private long competitionMasterId;
	private String sportType;
	private long teamSize;
	private String groundSize;
	private String netHeight;
	private long participantsCount;
	private String competitionType;
	private String weightCategories;
	private String boysEvents;
	private String girlsEvents;
	private String specialDetails;
	private Date createDate;
	private Date modifiedDate;
	private long userId;

	// Getters and Setters
	public long getSportDetailId() {
		return sportDetailId;
	}

	public void setSportDetailId(long sportDetailId) {
		this.sportDetailId = sportDetailId;
	}

	public long getCompetitionMasterId() {
		return competitionMasterId;
	}

	public void setCompetitionMasterId(long competitionMasterId) {
		this.competitionMasterId = competitionMasterId;
	}

	public String getSportType() {
		return sportType;
	}

	public void setSportType(String sportType) {
		this.sportType = sportType;
	}

	public long getTeamSize() {
		return teamSize;
	}

	public void setTeamSize(long teamSize) {
		this.teamSize = teamSize;
	}

	public String getGroundSize() {
		return groundSize;
	}

	public void setGroundSize(String groundSize) {
		this.groundSize = groundSize;
	}

	public String getNetHeight() {
		return netHeight;
	}

	public void setNetHeight(String netHeight) {
		this.netHeight = netHeight;
	}

	public long getParticipantsCount() {
		return participantsCount;
	}

	public void setParticipantsCount(long participantsCount) {
		this.participantsCount = participantsCount;
	}

	public String getCompetitionType() {
		return competitionType;
	}

	public void setCompetitionType(String competitionType) {
		this.competitionType = competitionType;
	}

	public String getWeightCategories() {
		return weightCategories;
	}

	public void setWeightCategories(String weightCategories) {
		this.weightCategories = weightCategories;
	}

	public String getBoysEvents() {
		return boysEvents;
	}

	public void setBoysEvents(String boysEvents) {
		this.boysEvents = boysEvents;
	}

	public String getGirlsEvents() {
		return girlsEvents;
	}

	public void setGirlsEvents(String girlsEvents) {
		this.girlsEvents = girlsEvents;
	}

	public String getSpecialDetails() {
		return specialDetails;
	}

	public void setSpecialDetails(String specialDetails) {
		this.specialDetails = specialDetails;
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

}
