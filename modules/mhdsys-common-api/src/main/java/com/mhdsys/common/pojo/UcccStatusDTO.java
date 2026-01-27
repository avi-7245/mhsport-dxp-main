package com.mhdsys.common.pojo;

import java.util.Date;

public class UcccStatusDTO {
	    private long ucccId;
	    private Date ucccRevisedCompletionDate;
	    private String workCompletedInTimeline;
	    private String ucccReason;
	    private String penalAction;
	    private long penalActionDoc;
	    private String penalActionDocURL;
	    private Date createdDate;
	    private Date modifiedDate;
	    private String createDateStr;
	    private String modifiedDateStr;
	    private long constructionTrackerId;
		public Date getUcccRevisedCompletionDate() {
			return ucccRevisedCompletionDate;
		}
		public void setUcccRevisedCompletionDate(Date ucccRevisedCompletionDate) {
			this.ucccRevisedCompletionDate = ucccRevisedCompletionDate;
		}
		public String getWorkCompletedInTimeline() {
			return workCompletedInTimeline;
		}
		public void setWorkCompletedInTimeline(String workCompletedInTimeline) {
			this.workCompletedInTimeline = workCompletedInTimeline;
		}
		public String getUcccReason() {
			return ucccReason;
		}
		public void setUcccReason(String ucccReason) {
			this.ucccReason = ucccReason;
		}
		public String getPenalAction() {
			return penalAction;
		}
		public void setPenalAction(String penalAction) {
			this.penalAction = penalAction;
		}
		public long getPenalActionDoc() {
			return penalActionDoc;
		}
		public void setPenalActionDoc(long penalActionDoc) {
			this.penalActionDoc = penalActionDoc;
		}
		public long getConstructionTrackerId() {
			return constructionTrackerId;
		}
		public void setConstructionTrackerId(long constructionTrackerId) {
			this.constructionTrackerId = constructionTrackerId;
		}
		
		public long getUcccId() {
			return ucccId;
		}
		public void setUcccId(long ucccId) {
			this.ucccId = ucccId;
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
		
		public Date getCreatedDate() {
			return createdDate;
		}
		public void setCreatedDate(Date createdDate) {
			this.createdDate = createdDate;
		}
		
		public String getPenalActionDocURL() {
			return penalActionDocURL;
		}
		public void setPenalActionDocURL(String penalActionDocURL) {
			this.penalActionDocURL = penalActionDocURL;
		}
		@Override
		public String toString() {
			return "UcccStatusDTO [ucccId=" + ucccId + ", ucccRevisedCompletionDate=" + ucccRevisedCompletionDate
					+ ", workCompletedInTimeline=" + workCompletedInTimeline + ", ucccReason=" + ucccReason
					+ ", penalAction=" + penalAction + ", penalActionDoc=" + penalActionDoc + ", penalActionDocURL="
					+ penalActionDocURL + ", createdDate=" + createdDate + ", modifiedDate=" + modifiedDate
					+ ", createDateStr=" + createDateStr + ", modifiedDateStr=" + modifiedDateStr
					+ ", constructionTrackerId=" + constructionTrackerId + "]";
		}
		
		
		
	    
}
