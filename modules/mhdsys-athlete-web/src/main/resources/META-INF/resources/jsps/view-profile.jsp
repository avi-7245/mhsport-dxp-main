<%@ include file="/init.jsp" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
.search-box {
    position: relative;
}
.search-icon {
    top: 50%;
    left: 12px;
    transform: translateY(-50%);
    color: #6c757d;
    pointer-events: none;
} 
.btn-icon {
    width: 40px;
    height: 40px;
    padding: 0;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border-radius: 8px;
}
.sidebar {
    position: fixed;
    top: 65px;
    left: 0;
    width: 250px;
    height: calc(100vh - 0px);
    overflow-y: auto;
    z-index: 999;
}
.sidebar .nav-link {
    display: flex;
    align-items: center;
    padding: 12px 16px;
    margin-bottom: 4px;
    color: #495057;
    text-decoration: none;
    border-radius: 8px;
    border: none;
    background: transparent;
    width: 100%;
    text-align: left;
    transition: all 0.2s;
}
 
 
.sidebar .nav-link i {
    margin-right: 12px;
    font-size: 1.1rem;
}
.main-content {
    margin-left: 170px;
    margin-top: 0px;
    padding: 0px;
    min-height: auto;
}
.view-content {
    display: none;
}
.view-content.active {
    display: block;
}
.avatar-large {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    font-weight: 600;
    flex-shrink: 0;
}
.avatar-small {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1rem;
    font-weight: 600;
    flex-shrink: 0;
}
.metric-card {
    transition: transform 0.2s, box-shadow 0.2s;
}
.metric-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}
.metric-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
}
.metric-icon i {
    font-size: 1.25rem;
}
.activities-list .activity-item {
    padding: 16px 0;
    border-bottom: 1px solid #e9ecef;
}
.activities-list .activity-item:last-child {
    border-bottom: none;
    padding-bottom: 0;
}
.athlete-card {
    transition: transform 0.2s, box-shadow 0.2s;
    cursor: pointer;
}
.athlete-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
}
.schedule-list .schedule-item {
    display: flex;
    gap: 16px;
    padding: 16px 0;
    border-bottom: 1px solid #e9ecef;
}
.schedule-list .schedule-item:last-child {
    border-bottom: none;
    padding-bottom: 0;
}
.schedule-bar {
    width: 4px;
    border-radius: 2px;
    flex-shrink: 0;
}
.goal-card {
    transition: transform 0.2s, box-shadow 0.2s;
}
.goal-card:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}
.achievements-list .achievement-item {
    display: flex;
    align-items: start;
    gap: 12px;
    margin-bottom: 16px;
}
.achievements-list .achievement-item:last-child {
    margin-bottom: 0;
}
.achievement-icon {
    width: 36px;
    height: 36px;
    border-radius: 8px;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
}
.meals-list .meal-item {
    padding: 12px 0;
    border-bottom: 1px solid #e9ecef;
}
.meals-list .meal-item:last-child {
    border-bottom: none;
    padding-bottom: 0;
}
.competitions-list .competition-item {
    padding: 20px 0;
    border-bottom: 1px solid #e9ecef;
}
.competitions-list .competition-item:last-child {
    border-bottom: none;
    padding-bottom: 0;
}
.results-list .result-item {
    padding: 16px 0;
    border-bottom: 1px solid #e9ecef;
}
.results-list .result-item:last-child {
    border-bottom: none;
    padding-bottom: 0;
}
.coming-soon {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    min-height: 400px;
    text-align: center;
}
.card {
    border: 1px solid #e9ecef;
    border-radius: 12px;
    box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
}
.bg-success-subtle {
    background-color: #d1e7dd !important;
}
.text-success {
    color: #198754 !important;
}
.bg-danger-subtle {
    background-color: #f8d7da !important;
}
.text-danger {
    color: #dc3545 !important;
}
.bg-warning-subtle {
    background-color: #fff3cd !important;
}
.text-warning {
    color: #ffc107 !important;
}
.bg-primary-subtle {
    background-color: #cfe2ff !important;
}
.text-primary {
    color: #0d6efd !important;
}
.bg-info-subtle {
    background-color: #cff4fc !important;
}
.text-info {
    color: #0dcaf0 !important;
}
@media (max-width: 992px) {
    .sidebar {
        transform: translateX(-100%);
        transition: transform 0.3s;
    }

    .sidebar.show {
        transform: translateX(0);
    }

    .main-content {
        margin-left: 0;
    }
}
@media (max-width: 768px) {
    .main-content {
        padding: 16px;
    }

    .header {
        padding: 12px !important;
    }

    .search-box {
        display: none;
    }
}
.sidebar::-webkit-scrollbar {
    width: 6px;
}
.sidebar::-webkit-scrollbar-track {
    background: #f1f1f1;
}
.sidebar::-webkit-scrollbar-thumb {
    background: #888;
    border-radius: 3px;
}
.sidebar::-webkit-scrollbar-thumb:hover {
    background: #555;
}
.progress {
    background-color: #e9ecef;
    border-radius: 4px;
}
.progress-bar {
    background-color: var(--primary-color);
    border-radius: 4px;
}
.nav-pills .nav-link {
    color: #6c757d;
    background-color: transparent;
    border-radius: 8px;
    padding: 8px 16px;
    border: none;
}
.nav-pills .nav-link.active {
    background-color: var(--primary-color);
    color: white;
}
.nav-pills .nav-link:not(.active):hover {
    background-color: #e9ecef;
}
.gap-2 {
    gap: 8px;
}
.gap-3 {
    gap: 16px;
}
.gap-4 {
    gap: 24px;
}
.health-metrics .health-metric-item {
    border-bottom: 1px solid #e9ecef;
}
.health-metrics .health-metric-item:last-child {
    border-bottom: none;
}


/* ------------------ Roster Sidebar CSS ------------------ */
.roster-sidebar {
    position: relative; 
    width: 100%;  
    max-width: 220px; 
 
    padding-right: 0;
    margin-bottom: 20px;
}

.tab-forms {
    padding-left: 20px; /* Space between roster sidebar and content */
}

/* Ensure nested tabs do not affect main sidebar */
.roster-sidebar .nav-link {
    border-radius: 5px !important;
    margin-bottom: 5px;
    display: flex;
    align-items: center;
    gap: 8px;
    color: #495057;
    background-color: #f8f9fa;
} 
.roster-sidebar .nav-link img {
    width: 18px;
    height: 18px;
}  
.form-body {
    border-radius: 15px;
}
.nav-pills .nav-link {
    border-radius: 0px !important;
}
.nav-pills .nav-link.active {
    color: white;
    background-color: #861f41;
}
.nav-pills .nav-link img {
    width: 18px;
    margin-right: 8px;
    filter: grayscale(100%) brightness(0) saturate(0);
    transition: 0.3s ease-in-out;
}
.nav-pills .nav-link.active img {
    filter: brightness(0) invert(1);
}
.card .card-header {
    background: #861f41;
    color: #fff;
    border-radius: 15px 15px 0 0;
    height: 50px;
    padding: 12px 20px;
    font-weight: 600;
}
.form-group label {
    margin: 0px 0 5px;
    color: #861f41;
    font-size: 13px;
    font-weight: 500;
}
 
/*.profile-card {
    background: #f9f9f9;
    border-radius: 10px;
    padding: 20px;
    text-align: center;
}
.profile-card img {
    width: 100px;
    border-radius: 50%;
    margin-bottom: 15px;
}
.profile-card p {
    margin: 5px 0;
    font-size: 14px;
    text-align: center;
    color: #26268e;
    font-weight: 600;
}*/
.profile-card {
    background: #f9f9f9;
    border-radius: 10px;
    padding: 20px;
    text-align: center;
}

.profile-card img {
    width: 100px;
    border-radius: 50%;
    margin-bottom: 15px;
}

.profile-info {
  text-align: left;
  margin-top: 10px;
}

.profile-info .row {
  align-items: center;
}

.profile-info .col-5 {
  text-transform: capitalize;
}

.profile-info .col-7 {
  color: #333;
}

.sidebar .nav-link.active {
    color: #fff;
    background: #861f41; 
}
.blue .sidebar .nav-link.active{
    color: #fff;
    background: #26268e; 
}
.light-color .sidebar .nav-link.active{
    color: #fff;
    background: #009990; 
}

</style>
  
    <!-- Sidebar --> 
    <aside class="sidebar bg-white border-end border-top">
        <nav class="nav flex-column p-3">
            <button class="nav-link active" data-view="dashboard">
                <i class="bi bi-house-door"></i><liferay-ui:message key="dashboard" />
            </button>
             <button class="nav-link" data-view="roster">
                <i class="bi bi-people"></i><liferay-ui:message key="athlete-details" />
            </button>
           <!--  <button class="nav-link" data-view="calendar">
                <i class="bi bi-calendar3"></i><liferay-ui:message key="training-calendar" />
            </button> -->
            <button class="nav-link" data-view="goals">
                <i class="bi bi-bullseye"></i><liferay-ui:message key="goals-and-targets" />
            </button>
            <button class="nav-link" data-view="analytics">
                <i class="bi bi-graph-up"></i><liferay-ui:message key="analytics" />
            </button>
            <button class="nav-link" data-view="nutrition">
                <i class="bi bi-egg-fried"></i><liferay-ui:message key="nutrition" />
            </button>
            <button class="nav-link" data-view="healthRecords">
                <i class="bi bi-heart-pulse"></i><liferay-ui:message key="health-records" />
            </button>
            <button class="nav-link" data-view="competitions">
                <i class="bi bi-trophy"></i><liferay-ui:message key="competitions" />
            </button>
           <!--  <button class="nav-link" data-view="reports">
                <i class="bi bi-file-text"></i><liferay-ui:message key="reports" />
            </button>
            <button class="nav-link" data-view="settings">
                <i class="bi bi-gear"></i><liferay-ui:message key="settings" />
            </button> -->
        </nav>
    </aside>


	<div class="row">
		<div class="col-12 d-flex justify-content-end mb-2"> 
			<a href="/group/guest/athelet-performance" class="btn btn-primary btn-sm rounded-pill back-btn-cn">
			<i class="bi bi-arrow-left-circle"></i> <liferay-ui:message key="back"/>
			</a>
		</div>
	</div>
    <!-- Main Content -->
    <main class="main-content"> 
            <!-- Dashboard View -->
            <div id="dashboardView" class="view-content active">
                <!-- Athlete Profile Card -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="d-flex gap-3">
                            <div class="avatar-large">  ${schoolCollege.firstName} ${schoolCollege.lastName}  </div>
                            <div class="flex-grow-1">
                                <div class="d-flex justify-content-between align-items-start"> 
                                    <div> 
                                        <h4 class="mb-1">    ${schoolCollege.firstName} ${schoolCollege.lastName}     </h4>
                                        <p class="text-muted mb-0"></p>
                                    </div> 
                                    <span class="badge bg-success-subtle text-success"><liferay-ui:message key="active" /></span>
                                </div>
                                <div class="row mt-3 g-3">
                                    <div class="col-md-4">
                                        <div class="d-flex align-items-center gap-2">
                                            <i class="bi bi-trophy text-warning"></i>  
                                            <div> 
                                                <p class="text-muted small mb-0"><liferay-ui:message key="medals" /></p>
                                                <p class="mb-0 fw-semibold">${medals}</p>
                                            </div> 
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="d-flex align-items-center gap-2">
                                            <i class="bi bi-bullseye text-primary"></i> 
                                            <div> 
                                                <p class="text-muted small mb-0"><liferay-ui:message key="personal-best" /></p>
                                                <p class="mb-0 fw-semibold">${highestMedal}</p>
                                            </div> 
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="d-flex align-items-center gap-2">
                                            <i class="bi bi-graph-up text-success"></i> 
                                            <div> 
                                                <p class="text-muted small mb-0"><liferay-ui:message key="performance" /></p>
                                                <p class="mb-0 fw-semibold">${performance}</p>
                                            </div> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                
                

                <!-- Metrics Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-md-6 col-lg-3">
                        <div class="card metric-card">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div class="flex-grow-1">
                                        <p class="text-muted mb-1"><liferay-ui:message key="speed-index" /></p>
                                        <h3 class="mb-1"></h3>
                                        <p class="text-success small mb-0"></p>
                                    </div>
                                    <div class="metric-icon bg-warning-subtle">
                                        <i class="bi bi-lightning-charge text-warning"></i>
                                    </div>
                                </div>
                                <div class="progress" style="height: 8px;">
                                    <div class="progress-bar" style="width: 92%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="card metric-card">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div class="flex-grow-1">
                                        <p class="text-muted mb-1"><liferay-ui:message key="endurance" /></p>
                                        <h3 class="mb-1"></h3>
                                        <p class="text-success small mb-0"></p>
                                    </div>
                                    <div class="metric-icon bg-primary-subtle">
                                        <i class="bi bi-activity text-primary"></i>
                                    </div>
                                </div>
                                <div class="progress" style="height: 8px;">
                                    <div class="progress-bar bg-primary" style="width: 85%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="card metric-card">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div class="flex-grow-1"> 
                                        <p class="text-muted mb-1"><liferay-ui:message key="heart-rate-avg" /></p>
                                        <h3 class="mb-1"></h3>
                                        <p class="text-success small mb-0"></p>
                                    </div>
                                    <div class="metric-icon bg-danger-subtle">
                                        <i class="bi bi-heart-pulse text-danger"></i>
                                    </div>
                                </div>
                                <div class="progress" style="height: 8px;">
                                    <div class="progress-bar bg-danger" style="width: 75%"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="card metric-card">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div class="flex-grow-1">
                                        <p class="text-muted mb-1"><liferay-ui:message key="strength-score" /></p>
                                        <h3 class="mb-1"></h3>
                                        <p class="text-success small mb-0"></p>
                                    </div>
                                    <div class="metric-icon" style="background-color: #e9d5ff;">
                                        <i class="bi bi-rulers" style="color: #a855f7;"></i>
                                    </div>
                                </div>
                                <div class="progress" style="height: 8px;">
                                    <div class="progress-bar" style="width: 78%; background-color: #a855f7;"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 

                <!-- Performance Chart and Health Monitoring -->
                <div class="row g-4 mb-4">
                    <div class="col-lg-8">
                         <!-- Recent Activities -->
			                <div class="card">
			                    <div class="card-body">
			                        <h5 class="mb-4"><liferay-ui:message key="recent-activities" /></h5>
			                        <div class="activities-list">
			                            <div class="activity-item">
			                                <div class="d-flex justify-content-between align-items-start">
			                                    <div class="flex-grow-1">
			                                        <div class="d-flex align-items-center gap-2 mb-2">
			                                            <span class="fw-semibold"><liferay-ui:message key="sprint-training" /></span>
			                                            <span class="badge bg-danger-subtle text-danger"></span>
			                                        </div> 
			                                        <div class="d-flex gap-3 text-muted small">
			                                            <span><i class="bi bi-clock"></i></span>
			                                            <span><i class="bi bi-geo-alt"></i></span>
			                                        </div>
			                                    </div>
			                                    <span class="text-muted small"></span>
			                                </div>
			                            </div>
			                            <div class="activity-item">
			                                <div class="d-flex justify-content-between align-items-start">
			                                    <div class="flex-grow-1">
			                                        <div class="d-flex align-items-center gap-2 mb-2">
			                                            <span class="fw-semibold"><liferay-ui:message key="strength-conditioning" /></span>
			                                            <span class="badge bg-warning-subtle text-warning"></span>
			                                        </div> 
			                                        <div class="d-flex gap-3 text-muted small">
			                                            <span><i class="bi bi-clock"></i></span>
			                                            <span><i class="bi bi-geo-alt"></i></span>
			                                        </div>
			                                    </div>
			                                    <span class="text-muted small"></span>
			                                </div>
			                            </div>
			                            <div class="activity-item">
			                                <div class="d-flex justify-content-between align-items-start">
			                                    <div class="flex-grow-1">
			                                        <div class="d-flex align-items-center gap-2 mb-2">
			                                            <span class="fw-semibold"><liferay-ui:message key="recovery-session" /></span>
			                                            <span class="badge bg-success-subtle text-success"></span>
			                                        </div> 
			                                        <div class="d-flex gap-3 text-muted small">
			                                            <span><i class="bi bi-clock"></i></span>
			                                            <span><i class="bi bi-geo-alt"></i></span>
			                                        </div>
			                                    </div>
			                                    <span class="text-muted small"></span>
			                                </div>
			                            </div>
			                            <div class="activity-item border-0 pb-0">
			                                <div class="d-flex justify-content-between align-items-start">
			                                    <div class="flex-grow-1">
			                                        <div class="d-flex align-items-center gap-2 mb-2">
			                                            <span class="fw-semibold"><liferay-ui:message key="speed-drills" /></span>
			                                            <span class="badge bg-danger-subtle text-danger"></span>
			                                        </div> 
			                                        <div class="d-flex gap-3 text-muted small">
			                                            <span><i class="bi bi-clock"></i></span>
			                                            <span><i class="bi bi-geo-alt"></i></span>
			                                        </div>
			                                    </div>
			                                    <span class="text-muted small"></span>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="card h-100">
                            <div class="card-body">
                                <h5 class="mb-4"><liferay-ui:message key="health-monitoring" /></h5>
                                <div class="health-metrics">
                                    <div class="health-metric-item mb-4">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <div class="d-flex align-items-center gap-2">
                                                <i class="bi bi-heart-pulse text-danger"></i>
                                                <span class="small"><liferay-ui:message key="resting-heart-rate" /></span>
                                            </div> 
                                            <div class="text-end">
                                                <p class="mb-0 text-danger fw-semibold"></p>
                                                <p class="mb-0 text-muted small"></p>
                                            </div>
                                        </div>
                                        <div class="progress" style="height: 6px;">
                                            <div class="progress-bar bg-danger" style="width: 90%"></div>
                                        </div>
                                    </div>
                                    <div class="health-metric-item mb-4">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <div class="d-flex align-items-center gap-2">
                                                <i class="bi bi-droplet text-primary"></i>
                                                <span class="small"><liferay-ui:message key="hydration-level" /></span>
                                            </div> 
                                            <div class="text-end">
                                                <p class="mb-0 text-primary fw-semibold"></p>
                                                <p class="mb-0 text-muted small"></p>
                                            </div>
                                        </div>
                                        <div class="progress" style="height: 6px;">
                                            <div class="progress-bar bg-primary" style="width: 82%"></div>
                                        </div>
                                    </div>
                                    <div class="health-metric-item mb-4">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <div class="d-flex align-items-center gap-2">
                                                <i class="bi bi-moon-stars" style="color: #a855f7;"></i>
                                                <span class="small"><liferay-ui:message key="sleep-quality" /></span>
                                            </div> 
                                            <div class="text-end">
                                                <p class="mb-0 fw-semibold" style="color: #a855f7;"></p>
                                                <p class="mb-0 text-muted small"></p>
                                            </div>
                                        </div>
                                        <div class="progress" style="height: 6px;">
                                            <div class="progress-bar" style="width: 85%; background-color: #a855f7;"></div>
                                        </div>
                                    </div>
                                    <div class="health-metric-item">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <div class="d-flex align-items-center gap-2">
                                                <i class="bi bi-speedometer2 text-success"></i>
                                                <span class="small"><liferay-ui:message key="body-composition" /></span>
                                            </div> 
                                            <div class="text-end">
                                                <p class="mb-0 text-success fw-semibold"></p>
                                                <p class="mb-0 text-muted small"></p>
                                            </div>
                                        </div>
                                        <div class="progress" style="height: 6px;">
                                            <div class="progress-bar bg-success" style="width: 88%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div> 
            </div>
            
            
            
            
            
   <div id="rosterView" class="view-content">
    <div class="container mt-5">
        <div class="row">
            <!-- Nested Roster Sidebar -->
            <div class="col-3 roster-sidebar">
                <div class="nav flex-column nav-pills border-0 shadow" id="v-pills-tab" role="tablist" aria-orientation="vertical">
                    <span class="nav-link active border-bottom py-3 m-0" id="v-pills-personal-tab" data-bs-toggle="pill"
                            data-bs-target="#v-pills-personal" type="button" role="tab">
                        <i class="bi bi-person-bounding-box"></i> Personal Details
                    </span>
                    <span class="nav-link border-bottom py-3 m-0" id="v-pills-injury-tab" data-bs-toggle="pill"
                            data-bs-target="#v-pills-injury" type="button" role="tab">
                        <i class="bi bi-bandaid"></i> Injury
                    </span>
                    <span class="nav-link border-bottom py-3 m-0" id="v-pills-ms-tab" data-bs-toggle="pill"
                            data-bs-target="#v-pills-ms" type="button" role="tab">
                        <i class="bi bi-display"></i> MS Screening
                    </span>
                    <span class="nav-link border-bottom py-3 m-0" id="v-pills-history-tab" data-bs-toggle="pill"
                            data-bs-target="#v-pills-history" type="button" role="tab">
                        <i class="bi bi-clock-history"></i> History
                    </span>
                    <span class="nav-link m-0 py-3" id="v-pills-exchange-tab" data-bs-toggle="pill"
                            data-bs-target="#v-pills-exchange" type="button" role="tab">
                        <i class="bi bi-arrow-clockwise"></i> Exchange List
                    </span>
                </div>
            </div>

            <!-- Content Area -->
            <div class="col-9 tab-forms">
                <div class="tab-content" id="v-pills-tabContent">
                    <!-- Personal Details Tab -->
                    <div class="tab-pane fade show active" id="v-pills-personal" role="tabpanel">
                        <!-- Personal details content here -->
                        
                        <div class="card border-0 shadow form-body">
                        <div class="card-header"><liferay-ui:message key="personal-details" /></div>
                        <div class="card-body">
                            <div class="row">
                                <!-- Profile Card -->
                                <!--  <div class="col-md-4">
                                    <div class="profile-card">
                                        <img src="${portraitURL}" alt="profile">
                                        <p><liferay-ui:message key="name" /> - ${schoolCollege.firstName} ${schoolCollege.lastName}</p>
                                        <p><liferay-ui:message key="mothers-name" /> - ${schoolCollege.mothersName}</p>
                                        <p><liferay-ui:message key="fathers-name" /> - ${schoolCollege.fathersName}</p>
                                    </div>
                                </div>-->
                                <div class="col-md-4">
  <div class="profile-card text-center p-3">
<img src="${portraitURL}" alt="profile">    
    <div class="profile-info text-start">
      <div class="row mb-2">
        <div class="col-5 fw-bold"><liferay-ui:message key="name" /></div>
        <div class="col-7">${schoolCollege.firstName} ${schoolCollege.lastName}</div>
      </div>
       <div class="row mb-2">
        <div class="col-5 fw-bold"><liferay-ui:message key="mothers-name" /></div>
        <div class="col-7">${schoolCollege.mothersName}</div>
      </div>
      <div class="row mb-2">
        <div class="col-5 fw-bold"><liferay-ui:message key="fathers-name" /></div>
        <div class="col-7">${schoolCollege.fathersName}</div>
      </div>
    </div>
  </div>
</div>
                                
                                <!-- Profile Info Form -->
                                <div class="col-md-8">
                                	
                                	<div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="gender" /><sup class="text-danger">*</sup></label>
                                                <input type="hidden" class="form-control" value="${schoolCollege.gender}" disabled>
                                                <input type="text" class="form-control" 
      											 value="${schoolCollege.gender == 1 ? 'Male' : (schoolCollege.gender == 2 ? 'Female' : '')}" disabled>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="designation" /><sup class="text-danger">*</sup></label>
                                                <input type="hidden" class="form-control" value="${schoolCollege.currentDesignation}" disabled>
                                                <input type="text" class="form-control"
                                                 value="${schoolCollege.currentDesignation == 1 ? 'Athlete' : (schoolCollege.currentDesignation == 2 ? 'Coach' : '')}" disabled>
                                            </div>
                                        </div>
                                    </div>
                                	
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="school-or-college-name" /><sup class="text-danger">*</sup></label>
                                                <input type="text" class="form-control" value="${schoolCollege.schoolOrCollegeName}" disabled>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="aadhaar-number" /><sup class="text-danger">*</sup></label>
                                                <input type="text" class="form-control" value="${schoolCollege.aadharNumber}" disabled>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="mobile-no" /><sup class="text-danger">*</sup></label>
                                                <input type="text" class="form-control" value="${schoolCollege.mobileNumber}" disabled>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label><liferay-ui:message key="dob" /><sup class="text-danger">*</sup></label>
                                                <input type="text" class="form-control" value="${formattedDOB}" disabled>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Add other personal details fields here -->
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    </div>

                    <!-- Injury Tab -->
                    <div class="tab-pane fade" id="v-pills-injury" role="tabpanel">
                        <!-- Injury content here -->
                        
                        <div class="card card-background p-0 border-0 shadow form-body">
					    <div class="card-header"><liferay-ui:message key="injury" /></div>
					    <div class="card-body">
					      <form>
					        <div class="row mb-3">
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="event" /></label>
					              <input type="text" class="form-control" name="event"
					                     value="${medicalReports.event != null ? medicalReports.event : ''}"
					                     <c:if test="${not empty medicalReports.event}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="training-age" /></label>
					              <input type="text" class="form-control" name="trainingAge"
					                     value="${medicalReports.trainingAge != null ? medicalReports.trainingAge : ''}"
					                     <c:if test="${not empty medicalReports.trainingAge}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="injury" /></label>
					              <input type="text" class="form-control" name="injury"
					                     value="${medicalReports.injury != null ? medicalReports.injury : ''}"
					                     <c:if test="${not empty medicalReports.injury}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					
					        <div class="row mb-3">
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="history-current-injury" /></label>
					              <input type="text" class="form-control" name="historyOfCurrentInjury"
					                     value="${medicalReports.historyOfCurrentInjury != null ? medicalReports.historyOfCurrentInjury : ''}"
					                     <c:if test="${not empty medicalReports.historyOfCurrentInjury}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="mechanism-of-injury" /></label>
					              <input type="text" class="form-control" name="mechanismOfInjury"
					                     value="${medicalReports.mechanismOfInjury != null ? medicalReports.mechanismOfInjury : ''}"
					                     <c:if test="${not empty medicalReports.mechanismOfInjury}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="area-of-injury" /></label>
					              <input type="text" class="form-control" name="areaOfInjury"
					                     value="${medicalReports.areaOfInjury != null ? medicalReports.areaOfInjury : ''}"
					                     <c:if test="${not empty medicalReports.areaOfInjury}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					
					        <div class="row mb-3">
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="affected-part" /></label>
					              <input type="text" class="form-control" name="affectedPart"
					                     value="${medicalReports.affectedPart != null ? medicalReports.affectedPart : ''}"
					                     <c:if test="${not empty medicalReports.affectedPart}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="on-observation" /></label>
					              <input type="text" class="form-control" name="onObservation"
					                     value="${medicalReports.onObservation != null ? medicalReports.onObservation : ''}"
					                     <c:if test="${not empty medicalReports.onObservation}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="odema" /></label>
					              <input type="text" class="form-control" name="odema"
					                     value="${medicalReports.odema != null ? medicalReports.odema : ''}"
					                     <c:if test="${not empty medicalReports.odema}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					
					        <div class="row mb-3">
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="pitting-non-pitting" /></label>
					              <input type="text" class="form-control" name="pittingType"
					                     value="${medicalReports.pittingType != null ? medicalReports.pittingType : ''}"
					                     <c:if test="${not empty medicalReports.pittingType}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="redness" /></label>
					              <input type="text" class="form-control" name="redness"
					                     value="${medicalReports.redness != null ? medicalReports.redness : ''}"
					                     <c:if test="${not empty medicalReports.redness}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="on-palpation" /></label>
					              <input type="text" class="form-control" name="onPalpation"
					                     value="${medicalReports.onPalpation != null ? medicalReports.onPalpation : ''}"
					                     <c:if test="${not empty medicalReports.onPalpation}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					
					        <div class="row mb-3">
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="tenderness" /></label>
					              <input type="text" class="form-control" name="tenderness"
					                     value="${medicalReports.tenderness != null ? medicalReports.tenderness : ''}"
					                     <c:if test="${not empty medicalReports.tenderness}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="stiffness" /></label>
					              <input type="text" class="form-control" name="stiffness"
					                     value="${medicalReports.stiffness != null ? medicalReports.stiffness : ''}"
					                     <c:if test="${not empty medicalReports.stiffness}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="pain" /></label>
					              <input type="text" class="form-control" name="pain"
					                     value="${medicalReports.pain != null ? medicalReports.pain : ''}"
					                     <c:if test="${not empty medicalReports.pain}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					
					        <div class="row mb-3">
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="vas-scale" /></label>
					              <input type="text" class="form-control" name="vasScale"
					                     value="${medicalReports.vasScale != null ? medicalReports.vasScale : ''}"
					                     <c:if test="${not empty medicalReports.vasScale}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="special-test" /></label>
					              <input type="text" class="form-control" name="specialTest"
					                     value="${medicalReports.specialTest != null ? medicalReports.specialTest : ''}"
					                     <c:if test="${not empty medicalReports.specialTest}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="treatment" /></label>
					              <input type="text" class="form-control" name="treatment"
					                     value="${medicalReports.treatment != null ? medicalReports.treatment : ''}"
					                     <c:if test="${not empty medicalReports.treatment}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					
					        <div class="row mb-3">
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="exercises-name-video" /></label>
					              <input type="text" class="form-control" name="exerciseVideo"
					                     value="${medicalReports.exerciseVideo != null ? medicalReports.exerciseVideo : ''}"
					                     <c:if test="${not empty medicalReports.exerciseVideo}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-4">
					            <div class="form-group">
					              <label><liferay-ui:message key="machine-work" /></label>
					              <input type="text" class="form-control" name="machineWork"
					                     value="${medicalReports.machineWork != null ? medicalReports.machineWork : ''}"
					                     <c:if test="${not empty medicalReports.machineWork}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					      </form>
					    </div>
					  </div>
					  
					  
                    </div>

                    <!-- MS Screening Tab -->
                    <div class="tab-pane fade" id="v-pills-ms" role="tabpanel">
                        <!-- MS screening content here -->
                        
                        <div class="card card-background p-0 border-0 shadow form-body">
					    <div class="card-header"><liferay-ui:message key="ms-screening" /></div>
					    <div class="card-body">
					      <form>
					        <div class="row mb-3">
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="kibler-lateral-slide-test" /></label>
					              <input type="text" class="form-control" name="kiblerLateralSlideRight"
					                     value="${medicalReports.kiblerLateralSlideRight != null ? medicalReports.kiblerLateralSlideRight : ''}"
					                     <c:if test="${not empty medicalReports.kiblerLateralSlideRight}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="kibler-lateral-slide-left" /></label>
					              <input type="text" class="form-control" name="kiblerLateralSlideLeft"
					                     value="${medicalReports.kiblerLateralSlideLeft != null ? medicalReports.kiblerLateralSlideLeft : ''}"
					                     <c:if test="${not empty medicalReports.kiblerLateralSlideLeft}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					
					        <div class="row mb-3">
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="rectus-femoris-length-test" /></label>
					              <input type="text" class="form-control" name="rectusFemorisLengthRight"
					                     value="${medicalReports.rectusFemorisLengthRight != null ? medicalReports.rectusFemorisLengthRight : ''}"
					                     <c:if test="${not empty medicalReports.rectusFemorisLengthRight}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="rectus-femoris-length-left" /></label>
					              <input type="text" class="form-control" name="rectusFemorisLengthLeft"
					                     value="${medicalReports.rectusFemorisLengthLeft != null ? medicalReports.rectusFemorisLengthLeft : ''}"
					                     <c:if test="${not empty medicalReports.rectusFemorisLengthLeft}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					
					        <div class="row mb-3">
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="hip-flexion-rom" /></label>
					              <input type="text" class="form-control" name="hipFlexionRomRight"
					                     value="${medicalReports.hipFlexionRomRight != null ? medicalReports.hipFlexionRomRight : ''}"
					                     <c:if test="${not empty medicalReports.hipFlexionRomRight}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="hip-flexion-rom-left" /></label>
					              <input type="text" class="form-control" name="hipFlexionRomLeft"
					                     value="${medicalReports.hipFlexionRomLeft != null ? medicalReports.hipFlexionRomLeft : ''}"
					                     <c:if test="${not empty medicalReports.hipFlexionRomLeft}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					      </form>
					    </div>
					  </div>
                        
                    </div>

                    <!-- History Tab -->
                    <div class="tab-pane fade" id="v-pills-history" role="tabpanel">
                        <!-- History content here -->
                        
                        <div class="card card-background p-0 border-0 shadow form-body">
					    <div class="card-header"><liferay-ui:message key="history" /></div>
					    <div class="card-body">
					      <form>
					        <div class="row mb-3">
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="ho-any-recent-injuries" /></label>
					              <input type="text" class="form-control" name="recentInjuries"
					                     value="${medicalReports.recentInjuries != null ? medicalReports.recentInjuries : ''}"
					                     <c:if test="${not empty medicalReports.recentInjuries}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="ho-any-comorbidities" /></label>
					              <input type="text" class="form-control" name="comorbidities"
					                     value="${medicalReports.comorbidities != null ? medicalReports.comorbidities : ''}"
					                     <c:if test="${not empty medicalReports.comorbidities}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					
					        <div class="row mb-3">
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="ho-any-surgeries" /></label>
					              <input type="text" class="form-control" name="surgeries"
					                     value="${medicalReports.surgeries != null ? medicalReports.surgeries : ''}"
					                     <c:if test="${not empty medicalReports.surgeries}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="any-medications" /></label>
					              <input type="text" class="form-control" name="medications"
					                     value="${medicalReports.medications != null ? medicalReports.medications : ''}"
					                     <c:if test="${not empty medicalReports.medications}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					
					        <div class="row mb-3">
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="family-history" /></label>
					              <input type="text" class="form-control" name="familyHistory"
					                     value="${medicalReports.familyHistory != null ? medicalReports.familyHistory : ''}"
					                     <c:if test="${not empty medicalReports.familyHistory}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					      </form>
					    </div>
					  </div>
                        
                    </div>

                    <!-- Exchange List Tab -->
                    <div class="tab-pane fade" id="v-pills-exchange" role="tabpanel">
                        <!-- Exchange list content here -->
                        
					  <div class="card card-background p-0 border-0 shadow form-body">
					    <div class="card-header"><liferay-ui:message key="exchange-list" /></div>
					    <div class="card-body">
					      <form action="exchangeDetails" method="post" id="exchangeDetails" autocomplete="off">
					        <div class="row mb-3">
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="ho-any-recent-injuries" /></label>
					              <input type="text" class="form-control" name="exchangeRecentInjuries"
					                     id="exchangeRecentInjuries"
					                     value="${medicalReports.exchangeRecentInjuries != null ? medicalReports.exchangeRecentInjuries : ''}"
					                     <c:if test="${not empty medicalReports.exchangeRecentInjuries}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="ho-any-comorbidities" /></label>
					              <input type="text" class="form-control" name="exchangeComorbidities"
					                     id="exchangeComorbidities"
					                     value="${medicalReports.exchangeComorbidities != null ? medicalReports.exchangeComorbidities : ''}"
					                     <c:if test="${not empty medicalReports.exchangeComorbidities}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					        <div class="row mb-3">
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="ho-any-surgeries" /></label>
					              <input type="text" class="form-control" name="exchangeSurgeries"
					                     id="exchangeSurgeries"
					                     value="${medicalReports.exchangeSurgeries != null ? medicalReports.exchangeSurgeries : ''}"
					                     <c:if test="${not empty medicalReports.exchangeSurgeries}">disabled</c:if> />
					            </div>
					          </div>
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="any-medications" /></label>
					              <input type="text" class="form-control" name="exchangeMedications"
					                     id="exchangeMedications"
					                     value="${medicalReports.exchangeMedications != null ? medicalReports.exchangeMedications : ''}"
					                     <c:if test="${not empty medicalReports.exchangeMedications}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					        <div class="row mb-3">
					          <div class="col-md-6">
					            <div class="form-group">
					              <label><liferay-ui:message key="family-history" /></label>
					              <input type="text" class="form-control" name="exchangeFamilyHistory"
					                     id="exchangeFamilyHistory"
					                     value="${medicalReports.exchangeFamilyHistory != null ? medicalReports.exchangeFamilyHistory : ''}"
					                     <c:if test="${not empty medicalReports.exchangeFamilyHistory}">disabled</c:if> />
					            </div>
					          </div>
					        </div>
					      </form>
					    </div>
					  </div>
					
					
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


	<div id="analyticsView" class="view-content">
	    <div class="container mt-5">
	        <div class="row">
	        </div>
	    </div>
	</div>
	
	
	<div id="healthRecordsView" class="view-content">
	    <div class="container mt-5">
	        <div class="row">
	        </div>
	    </div>
	</div>
	
            
            <!-- Training Calendar View -->
            <div id="calendarView" class="view-content">
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <h3><liferay-ui:message key="training-calendar" /></h3>
                        <p class="text-muted"><liferay-ui:message key="schedule-and-manage-training-sessions" /></p>
                    </div>
                    <button class="btn btn-primary"><liferay-ui:message key="schedule-session" /></button>
                </div>

                <div class="row g-4">
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="mb-3"><liferay-ui:message key="calendar" /></h5>
                                <div id="calendarWidget" class="calendar-widget">
                                    <!-- Simple calendar will be here -->
                                    <div class="text-center p-4 border rounded">
                                        <h4 class="mb-0"></h4>
                                        <div class="calendar-grid mt-3">
                                            <small class="text-muted"></small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-8">
                        <div class="card mb-4">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h5 class="mb-0"><liferay-ui:message key="todays-schedule" /></h5>
                                    <span class="badge bg-primary"></span>
                                </div>
                                <div class="schedule-list">
                                    <div class="schedule-item">
                                        <div class="schedule-bar bg-primary"></div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <h6 class="mb-2"><liferay-ui:message key="morning" /><liferay-ui:message key="morning-sprint-training" /></h6>
                                                    <div class="d-flex gap-3 text-muted small">
                                                        <span><i class="bi bi-clock"></i></span>
                                                        <span><i class="bi bi-geo-alt"></i></span>
                                                    </div>
                                                </div>
                                                <span class="badge bg-light text-dark"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="schedule-item">
                                        <div class="schedule-bar" style="background-color: #a855f7;"></div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <h6 class="mb-2"><liferay-ui:message key="strength-and-conditioning" /></h6>
                                                    <div class="d-flex gap-3 text-muted small">
                                                        <span><i class="bi bi-clock"></i> </span>
                                                        <span><i class="bi bi-geo-alt"></i> </span>
                                                    </div>
                                                </div>
                                                <span class="badge bg-light text-dark"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="schedule-item">
                                        <div class="schedule-bar bg-success"></div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <h6 class="mb-2"><liferay-ui:message key="technical-skills" /></h6>
                                                    <div class="d-flex gap-3 text-muted small">
                                                        <span><i class="bi bi-clock"></i></span>
                                                        <span><i class="bi bi-geo-alt"></i></span>
                                                    </div>
                                                </div>
                                                <span class="badge bg-light text-dark"></span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="schedule-item border-0 pb-0">
                                        <div class="schedule-bar bg-warning"></div>
                                        <div class="flex-grow-1">
                                            <div class="d-flex justify-content-between">
                                                <div>
                                                    <h6 class="mb-2"><liferay-ui:message key="recovery-session" /></h6>
                                                    <div class="d-flex gap-3 text-muted small">
                                                        <span><i class="bi bi-clock"></i></span>
                                                        <span><i class="bi bi-geo-alt"></i></span>
                                                    </div>
                                                </div>
                                                <span class="badge bg-light text-dark"></span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-body">
                                <h5 class="mb-4"><liferay-ui:message key="weekly-summary" /></h5>
                                <div class="row text-center">
                                    <div class="col-3">
                                        <p class="text-muted small mb-1"><liferay-ui:message key="total-hours" /></p>
                                        <h5 class="mb-0"></h5>
                                    </div>
                                    <div class="col-3">
                                        <p class="text-muted small mb-1"></p>
                                        <h5 class="mb-0"></h5>
                                    </div>
                                    <div class="col-3">
                                        <p class="text-muted small mb-1"></p>
                                        <h5 class="mb-0"></h5>
                                    </div>
                                    <div class="col-3">
                                        <p class="text-muted small mb-1"></p>
                                        <h5 class="mb-0"></h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Goals & Targets View -->
            <div id="goalsView" class="view-content">
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <h3><liferay-ui:message key="goals-and-targets" /></h3>
                        <p class="text-muted"><liferay-ui:message key="track-progress-towards-objectives" /></p>
                    </div>
                    <button class="btn btn-primary"><liferay-ui:message key="set-new-goal" /></button>
                </div>

                <div class="row g-4">
                    <div class="col-lg-8">
                        <div class="goals-list">
                            <!-- Goals will be dynamically populated -->
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="mb-4"><liferay-ui:message key="recent-achievements" /></h5>
                                <div class="achievements-list">
                                    <div class="achievement-item">
                                        <div class="achievement-icon bg-warning-subtle">
                                            <i class="bi bi-award text-warning"></i>
                                        </div>
                                        <div>
                                            <p class="mb-0 small"></p>
                                            <p class="mb-0 text-muted small"></p>
                                        </div>
                                    </div>
                                    <div class="achievement-item">
                                        <div class="achievement-icon bg-warning-subtle">
                                            <i class="bi bi-calendar-check text-warning"></i>
                                        </div>
                                        <div>
                                            <p class="mb-0 small"></p>
                                            <p class="mb-0 text-muted small"></p>
                                        </div>
                                    </div>
                                    <div class="achievement-item mb-0">
                                        <div class="achievement-icon bg-warning-subtle">
                                            <i class="bi bi-graph-up text-warning"></i>
                                        </div>
                                        <div>
                                            <p class="mb-0 small"></p>
                                            <p class="mb-0 text-muted small"></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-body">
                                <h5 class="mb-4"><liferay-ui:message key="goal-categories" /></h5>
                                <div class="category-list">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="small"><liferay-ui:message key="performance" /></span>
                                        <span class="badge bg-light text-dark"></span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="small"></span>
                                        <span class="badge bg-light text-dark"></span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <span class="small"></span>
                                        <span class="badge bg-light text-dark"></span>
                                    </div>
                                    <div class="d-flex justify-content-between align-items-center">
                                        <span class="small"></span>
                                        <span class="badge bg-light text-dark"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Nutrition Tracking View -->
            <div id="nutritionView" class="view-content">
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <h3><liferay-ui:message key="nutrition-tracking" /></h3>
                        <p class="text-muted"></p>
                    </div>
                    <button class="btn btn-primary"></button>
                </div>

                <div class="row g-4">
                    <div class="col-lg-8">
                        <div class="row g-3 mb-4">
                            <div class="col-md-3 col-sm-6">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <i class="bi bi-fire text-danger"></i>
                                            <span class="badge bg-light text-dark"></span>
                                        </div>
                                        <p class="text-muted small mb-1"></p>
                                        <p class="mb-1 fw-semibold"></p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-danger" style="width: 88%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <i class="bi bi-activity text-primary"></i>
                                            <span class="badge bg-light text-dark"></span>
                                        </div>
                                        <p class="text-muted small mb-1"></p>
                                        <p class="mb-1 fw-semibold"></p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-primary" style="width: 92%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <i class="bi bi-droplet text-info"></i>
                                            <span class="badge bg-light text-dark"></span>
                                        </div>
                                        <p class="text-muted small mb-1"></p>
                                        <p class="mb-1 fw-semibold"></p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-info" style="width: 80%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 col-sm-6">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <i class="bi bi-egg-fried text-success"></i>
                                            <span class="badge bg-light text-dark"></span>
                                        </div>
                                        <p class="text-muted small mb-1"></p>
                                        <p class="mb-1 fw-semibold"></p>
                                        <div class="progress" style="height: 4px;">
                                            <div class="progress-bar bg-success" style="width: 80%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-body">
                                <h5 class="mb-4"><liferay-ui:message key="todays-meals" /></h5>
                                <div class="meals-list">
                                    <!-- Meals will be dynamically populated -->
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="mb-4"><liferay-ui:message key="macros-distribution" /></h5>
                                <canvas id="nutritionChart" height="200"></canvas>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-body">
                                <h5 class="mb-4"><liferay-ui:message key="weekly-stats" /></h5>
                                <div class="weekly-stats">
                                    <div class="mb-3">
                                        <div class="d-flex justify-content-between small mb-1">
                                            <span></span>
                                            <span></span>
                                        </div>
                                        <div class="progress" style="height: 6px;">
                                            <div class="progress-bar" style="width: 95%"></div>
                                        </div>
                                    </div>
                                    <div class="mb-3">
                                        <div class="d-flex justify-content-between small mb-1">
                                            <span></span>
                                            <span></span>
                                        </div>
                                        <div class="progress" style="height: 6px;">
                                            <div class="progress-bar" style="width: 92%"></div>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="d-flex justify-content-between small mb-1">
                                            <span></span>
                                            <span></span>
                                        </div>
                                        <div class="progress" style="height: 6px;">
                                            <div class="progress-bar" style="width: 88%"></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>



            <!-- Competitions View -->
            <div id="competitionsView" class="view-content">
                <div class="d-flex justify-content-between align-items-start mb-4">
                    <div>
                        <h3><liferay-ui:message key="competitions" /></h3>
                        <p class="text-muted"><liferay-ui:message key="track-competitions-details" /></p>
                    </div>
                    <!-- <button class="btn btn-primary"></button> -->
                </div>

                <div class="row g-4">
                    <!-- <div class="col-lg-8">
                        <div class="card">
                            <div class="card-body">
                                <h5 class="mb-4"><liferay-ui:message key="upcoming-events" /></h5>
                                <div class="competitions-list">
                                    Competitions will be dynamically populated
                                </div>
                            </div>
                        </div>
                    </div> -->

                    <div class="col-lg-4">
                        <!-- <div class="card mb-4">
                            <div class="card-body">
                                <div class="d-flex align-items-center gap-2 mb-4">
                                    <i class="bi bi-trophy text-warning"></i>
                                    <h5 class="mb-0"><liferay-ui:message key="recent-results" /></h5>
                                </div>
                                <div class="results-list">
                                    Results will be dynamically populated
                                </div>
                            </div>
                        </div> -->

                        <div class="card">
                            <div class="card-body">
                                <h5 class="mb-4"><liferay-ui:message key="stats" /></h5>
                                <div class="season-stats">
                                    <div class="d-flex justify-content-between mb-3">
                                        <span class="text-muted small"><liferay-ui:message key="total-competitions" /></span>
                                        <span class="fw-semibold">${totalCompetitions}</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3">
                                        <span class="text-muted small"><liferay-ui:message key="gold-medals" /></span>
                                        <span class="fw-semibold text-warning">${gold}</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3">
                                        <span class="text-muted small"><liferay-ui:message key="silver-medals" /></span>
                                        <span class="fw-semibold" style="color: #9ca3af;">${silver}</span>
                                    </div>
                                    <div class="d-flex justify-content-between mb-3">
                                        <span class="text-muted small"><liferay-ui:message key="bronze-medals" /></span>
                                        <span class="fw-semibold" style="color: #ea580c;">${bronze}</span>
                                    </div>
                                    <div class="d-flex justify-content-between">
                                        <span class="text-muted small"><liferay-ui:message key="win-rate" /></span>
                                        <span class="fw-semibold text-success"></span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        
    </main>

  
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
<script>
(function() {
    'use strict';
    var athletes = [
        { id: 1, name: 'Rajesh Patil', sport: 'Track & Field', event: '100m Sprint', status: 'Active', performance: 92, initials: 'RP' },
        { id: 2, name: 'Priya Sharma', sport: 'Swimming', event: 'Freestyle', status: 'Active', performance: 88, initials: 'PS' },
        { id: 3, name: 'Amit Kumar', sport: 'Wrestling', event: '75kg', status: 'Training', performance: 85, initials: 'AK' },
        { id: 4, name: 'Sneha Desai', sport: 'Badminton', event: 'Singles', status: 'Active', performance: 90, initials: 'SD' },
        { id: 5, name: 'Vikram Singh', sport: 'Boxing', event: 'Middleweight', status: 'Recovery', performance: 82, initials: 'VS' },
        { id: 6, name: 'Kavita Rao', sport: 'Athletics', event: 'Long Jump', status: 'Active', performance: 87, initials: 'KR' },
        { id: 7, name: 'Rahul Joshi', sport: 'Football', event: 'Forward', status: 'Active', performance: 89, initials: 'RJ' },
        { id: 8, name: 'Anjali Patil', sport: 'Tennis', event: 'Singles', status: 'Training', performance: 86, initials: 'AP' }
    ];

    var goals = [
        {
            id: 1,
            title: 'Improve 100m Sprint Time',
            target: '10.30s',
            current: '10.45s',
            progress: 75,
            deadline: 'Dec 2025',
            status: 'On Track',
            category: 'Performance'
        },
        {
            id: 2,
            title: 'Increase Strength Score',
            target: '90/100',
            current: '78/100',
            progress: 65,
            deadline: 'Nov 2025',
            status: 'In Progress',
            category: 'Strength'
        },
        {
            id: 3,
            title: 'Reduce Body Fat Percentage',
            target: '10%',
            current: '12%',
            progress: 80,
            deadline: 'Oct 2025',
            status: 'On Track',
            category: 'Health'
        },
        {
            id: 4,
            title: 'Win State Championship',
            target: 'Gold Medal',
            current: 'Qualified',
            progress: 50,
            deadline: 'Jan 2026',
            status: 'In Progress',
            category: 'Competition'
        }
    ];

    var meals = [
        { id: 1, time: '07:00 AM', meal: 'Breakfast', items: 'Oats, Eggs, Banana, Milk', calories: 680 },
        { id: 2, time: '10:30 AM', meal: 'Mid-Morning Snack', items: 'Protein Shake, Nuts', calories: 350 },
        { id: 3, time: '01:00 PM', meal: 'Lunch', items: 'Chicken, Rice, Vegetables, Dal', calories: 820 },
        { id: 4, time: '04:00 PM', meal: 'Pre-Workout', items: 'Banana, Energy Bar', calories: 280 },
        { id: 5, time: '07:30 PM', meal: 'Dinner', items: 'Fish, Quinoa, Salad', calories: 720 }
    ];

    var upcomingEvents = [
        {
            id: 1,
            name: 'Maharashtra State Athletics Championship',
            date: 'Nov 15-18, 2025',
            location: 'Pune, Maharashtra',
            category: 'State Level',
            status: 'Registered',
            events: ['100m Sprint', '200m Sprint']
        },
        {
            id: 2,
            name: 'National Junior Athletics Meet',
            date: 'Dec 5-10, 2025',
            location: 'New Delhi',
            category: 'National Level',
            status: 'Pending',
            events: ['100m Sprint']
        },
        {
            id: 3,
            name: 'Mumbai Open Track & Field',
            date: 'Jan 20-22, 2026',
            location: 'Mumbai, Maharashtra',
            category: 'City Level',
            status: 'Registered',
            events: ['100m Sprint', '4x100m Relay']
        }
    ];

    var pastResults = [
        {
            id: 1,
            name: 'Inter-District Athletics Championship',
            date: 'Sep 2025',
            position: '1st',
            medal: 'Gold',
            time: '10.45s'
        },
        {
            id: 2,
            name: 'Zonal Athletics Meet',
            date: 'Aug 2025',
            position: '2nd',
            medal: 'Silver',
            time: '10.52s'
        },
        {
            id: 3,
            name: 'State Qualifiers',
            date: 'Jul 2025',
            position: '1st',
            medal: 'Gold',
            time: '10.48s'
        }
    ];

    var performanceChart = null;
    var nutritionChart = null;

    function init() {
        setupNavigation();
        setupCharts();
        renderAthletes();
        renderGoals();
        renderMeals();
        renderCompetitions();
        renderResults();
    }

    function setupNavigation() {
        var navLinks = document.querySelectorAll('.sidebar .nav-link');
        
        for (var i = 0; i < navLinks.length; i++) {
            navLinks[i].addEventListener('click', function(e) {
                e.preventDefault();
                var view = this.getAttribute('data-view');
                switchView(view);
                
                var allLinks = document.querySelectorAll('.sidebar .nav-link');
                for (var j = 0; j < allLinks.length; j++) {
                    allLinks[j].classList.remove('active');
                }
                this.classList.add('active');
            });
        }
    }

    function switchView(viewName) {
        var allViews = document.querySelectorAll('.view-content');
        for (var i = 0; i < allViews.length; i++) {
            allViews[i].classList.remove('active');
        }
        
        var targetView = document.getElementById(viewName + 'View');
        if (targetView) {
            targetView.classList.add('active');
        }
    }

    function setupCharts() {
        setupPerformanceChart();
        setupNutritionChart();
        setupChartTabs();
    }

    function setupPerformanceChart() {
        var ctx = document.getElementById('performanceChart');
        if (!ctx) return;

        var performanceData = {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [
                {
                    label: 'Speed',
                    data: [88, 89, 87, 90, 91, 92],
                    borderColor: '#f59e0b',
                    backgroundColor: 'rgba(245, 158, 11, 0.1)',
                    tension: 0.4
                },
                {
                    label: 'Endurance',
                    data: [82, 83, 85, 84, 85, 85],
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                    tension: 0.4
                },
                {
                    label: 'Strength',
                    data: [75, 76, 77, 78, 77, 78],
                    borderColor: '#8b5cf6',
                    backgroundColor: 'rgba(139, 92, 246, 0.1)',
                    tension: 0.4
                }
            ]
        };

        var config = {
            type: 'line',
            data: performanceData,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: true,
                        position: 'bottom'
                    }
                },
                scales: {
                    y: {
                        beginAtZero: false,
                        min: 70,
                        max: 100
                    }
                }
            }
        };

        performanceChart = new Chart(ctx, config);
    }

    function setupChartTabs() {
        var chartTabs = document.querySelectorAll('#chartTabs .nav-link');
        
        for (var i = 0; i < chartTabs.length; i++) {
            chartTabs[i].addEventListener('click', function(e) {
                e.preventDefault();
                var chartType = this.getAttribute('data-chart');
                
                var allTabs = document.querySelectorAll('#chartTabs .nav-link');
                for (var j = 0; j < allTabs.length; j++) {
                    allTabs[j].classList.remove('active');
                }
                this.classList.add('active');
                
                updatePerformanceChart(chartType);
            });
        }
    }

    function updatePerformanceChart(chartType) {
        if (!performanceChart) return;

        var newData;
        if (chartType === 'training') {
            newData = {
                labels: ['Week 1', 'Week 2', 'Week 3', 'Week 4', 'Week 5', 'Week 6'],
                datasets: [
                    {
                        label: 'Training Hours',
                        data: [12, 14, 13, 15, 16, 14],
                        borderColor: '#10b981',
                        backgroundColor: 'rgba(16, 185, 129, 0.1)',
                        tension: 0.4
                    },
                    {
                        label: 'Intensity %',
                        data: [75, 78, 80, 82, 85, 83],
                        borderColor: '#ef4444',
                        backgroundColor: 'rgba(239, 68, 68, 0.1)',
                        tension: 0.4
                    }
                ]
            };
        } else {
            newData = {
                labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                datasets: [
                    {
                        label: 'Speed',
                        data: [88, 89, 87, 90, 91, 92],
                        borderColor: '#f59e0b',
                        backgroundColor: 'rgba(245, 158, 11, 0.1)',
                        tension: 0.4
                    },
                    {
                        label: 'Endurance',
                        data: [82, 83, 85, 84, 85, 85],
                        borderColor: '#3b82f6',
                        backgroundColor: 'rgba(59, 130, 246, 0.1)',
                        tension: 0.4
                    },
                    {
                        label: 'Strength',
                        data: [75, 76, 77, 78, 77, 78],
                        borderColor: '#8b5cf6',
                        backgroundColor: 'rgba(139, 92, 246, 0.1)',
                        tension: 0.4
                    }
                ]
            };
        }
        performanceChart.data = newData;
        performanceChart.update();
    }

    function setupNutritionChart() {
        var ctx = document.getElementById('nutritionChart');
        if (!ctx) return;

        var data = {
            labels: ['Protein', 'Carbs', 'Fats'],
            datasets: [{
                data: [35, 45, 20],
                backgroundColor: ['#3b82f6', '#f59e0b', '#10b981'],
                borderWidth: 0
            }]
        };

        var config = {
            type: 'doughnut',
            data: data,
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom'
                    }
                }
            }
        };
        nutritionChart = new Chart(ctx, config);
    }

    function renderAthletes() {
        var container = document.getElementById('athleteGrid');
        if (!container) return;

        var html = '';
        for (var i = 0; i < athletes.length; i++) {
            var athlete = athletes[i];
            var statusClass = athlete.status === 'Active' ? 'bg-success-subtle text-success' :
                             athlete.status === 'Training' ? 'bg-primary-subtle text-primary' :
                             'bg-warning-subtle text-warning';
            
            html += '<div class="col-md-6 col-lg-4">';
            html += '  <div class="card athlete-card">';
            html += '    <div class="card-body">';
            html += '      <div class="d-flex gap-3 mb-3">';
            html += '        <div class="avatar-small">' + athlete.initials + '</div>';
            html += '        <div class="flex-grow-1">';
            html += '          <h6 class="mb-1">' + athlete.name + '</h6>';
            html += '          <p class="text-muted small mb-0">' + athlete.sport + '</p>';
            html += '          <p class="text-muted small mb-0">' + athlete.event + '</p>';
            html += '        </div>';
            html += '      </div>';
            html += '      <div class="d-flex justify-content-between align-items-center">';
            html += '        <span class="badge ' + statusClass + '">' + athlete.status + '</span>';
            html += '        <div class="text-end">';
            html += '          <p class="text-muted small mb-0">Performance</p>';
            html += '          <p class="text-primary mb-0 fw-semibold">' + athlete.performance + '/100</p>';
            html += '        </div>';
            html += '      </div>';
            html += '    </div>';
            html += '  </div>';
            html += '</div>';
        }
        
        container.innerHTML = html;
    }

    function renderGoals() {
        var container = document.querySelector('.goals-list');
        if (!container) return;

        var html = '';
        for (var i = 0; i < goals.length; i++) {
            var goal = goals[i];
            var statusClass = goal.status === 'On Track' ? 'bg-success-subtle text-success' : 'bg-primary-subtle text-primary';
            
            html += '<div class="card goal-card mb-3">';
            html += '  <div class="card-body">';
            html += '    <div class="d-flex justify-content-between align-items-start mb-3">';
            html += '      <div class="d-flex gap-3">';
            html += '        <i class="bi bi-bullseye text-primary" style="font-size: 1.25rem;"></i>';
            html += '        <div>';
            html += '          <h6 class="mb-1">' + goal.title + '</h6>';
            html += '          <p class="text-muted small mb-0">Current: ' + goal.current + ' → Target: ' + goal.target + '</p>';
            html += '        </div>';
            html += '      </div>';
            html += '      <span class="badge ' + statusClass + '">' + goal.status + '</span>';
            html += '    </div>';
            html += '    <div class="progress mb-2" style="height: 8px;">';
            html += '      <div class="progress-bar" style="width: ' + goal.progress + '%"></div>';
            html += '    </div>';
            html += '    <div class="d-flex justify-content-between text-muted small">';
            html += '      <span>' + goal.progress + '% Complete</span>';
            html += '      <span>Deadline: ' + goal.deadline + '</span>';
            html += '    </div>';
            html += '  </div>';
            html += '</div>';
        }
        container.innerHTML = html;
    }

    function renderMeals() {
        var container = document.querySelector('.meals-list');
        if (!container) return;

        var html = '';
        for (var i = 0; i < meals.length; i++) {
            var meal = meals[i];
            var isLast = i === meals.length - 1;
            
            html += '<div class="meal-item ' + (isLast ? 'border-0 pb-0' : '') + '">';
            html += '  <div class="d-flex justify-content-between align-items-start">';
            html += '    <div class="flex-grow-1">';
            html += '      <div class="d-flex align-items-center gap-2 mb-1">';
            html += '        <span class="fw-semibold">' + meal.meal + '</span>';
            html += '        <span class="text-muted small">' + meal.time + '</span>';
            html += '      </div>';
            html += '      <p class="text-muted small mb-0">' + meal.items + '</p>';
            html += '    </div>';
            html += '    <span class="badge bg-light text-dark">' + meal.calories + ' kcal</span>';
            html += '  </div>';
            html += '</div>';
        }
        container.innerHTML = html;
    }

    function renderCompetitions() {
        var container = document.querySelector('.competitions-list');
        if (!container) return;

        var html = '';
        for (var i = 0; i < upcomingEvents.length; i++) {
            var event = upcomingEvents[i];
            var isLast = i === upcomingEvents.length - 1;
            var statusClass = event.status === 'Registered' ? 'bg-success-subtle text-success' : 'bg-warning-subtle text-warning';
            
            html += '<div class="competition-item ' + (isLast ? 'border-0 pb-0' : '') + '">';
            html += '  <div class="d-flex justify-content-between align-items-start mb-2">';
            html += '    <div>';
            html += '      <h6 class="mb-2">' + event.name + '</h6>';
            html += '      <span class="badge bg-light text-dark">' + event.category + '</span>';
            html += '    </div>';
            html += '    <span class="badge ' + statusClass + '">' + event.status + '</span>';
            html += '  </div>';
            html += '  <div class="d-flex gap-3 text-muted small mt-3">';
            html += '    <span><i class="bi bi-calendar3"></i> ' + event.date + '</span>';
            html += '    <span><i class="bi bi-geo-alt"></i> ' + event.location + '</span>';
            html += '  </div>';
            html += '  <p class="text-muted small mt-2 mb-0">Events: ' + event.events.join(', ') + '</p>';
            html += '</div>';
        }
        container.innerHTML = html;
    }

    function renderResults() {
        var container = document.querySelector('.results-list');
        if (!container) return;

        var html = '';
        for (var i = 0; i < pastResults.length; i++) {
            var result = pastResults[i];
            var isLast = i === pastResults.length - 1;
            var medalClass = result.medal === 'Gold' ? 'bg-warning-subtle text-warning' :
                            result.medal === 'Silver' ? 'bg-secondary bg-opacity-25 text-secondary' :
                            'bg-danger bg-opacity-10 text-danger';
            
            html += '<div class="result-item ' + (isLast ? 'border-0 pb-0' : '') + '">';
            html += '  <div class="d-flex justify-content-between align-items-center mb-2">';
            html += '    <span class="badge ' + medalClass + '">';
            html += '      <i class="bi bi-award"></i> ' + result.medal;
            html += '    </span>';
            html += '    <span class="small fw-semibold">' + result.position + '</span>';
            html += '  </div>';
            html += '  <p class="small mb-1">' + result.name + '</p>';
            html += '  <div class="d-flex justify-content-between text-muted small">';
            html += '    <span>' + result.date + '</span>';
            html += '    <span>Time: ' + result.time + '</span>';
            html += '  </div>';
            html += '</div>';
        }
        
        container.innerHTML = html;
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }
})(); 

document.addEventListener('DOMContentLoaded', function() {
    const rosterTabButtons = document.querySelectorAll('.roster-sidebar .nav-link[data-bs-toggle="pill"]');
    
    if (rosterTabButtons.length > 0) {
        rosterTabButtons[0].classList.add('active');
        const firstTab = rosterTabButtons[0].getAttribute('data-bs-target');
        document.querySelector(firstTab).classList.add('show', 'active');
    }

    rosterTabButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            e.preventDefault();

            const targetId = this.getAttribute('data-bs-target');

            rosterTabButtons.forEach(btn => btn.classList.remove('active'));
            document.querySelectorAll('.roster-tab-pane').forEach(pane => pane.classList.remove('show', 'active'));

            this.classList.add('active');
            document.querySelector(targetId).classList.add('show', 'active');
        });
    });
});


    $('.nav-link[data-view="analytics"]').on('click', function() {
        $('#analyticsView .row').html('<div class="text-center text-muted w-100">No details available</div>');
    });
    
    $('.nav-link[data-view="healthRecords"]').on('click', function() {
        $('#healthRecordsView .row').html('<div class="text-center text-muted w-100">No details available</div>');
    });
</script>