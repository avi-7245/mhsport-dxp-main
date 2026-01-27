<%@ include file="/init.jsp"%>
<div class="container-fluid dashboardPage">

    <!-- First Row: Back Button -->
    <div class="row mb-3">
        <div class="col-12 d-flex justify-content-end">
            <a href="/group/guest/dashboard" class="btn btn-primary btn-sm rounded-pill back-btn-cn">
                <i class="bi bi-arrow-left-circle"></i> <liferay-ui:message key="back" />
            </a>
        </div>
    </div>

    <!-- Second Row: Cards -->
    <div class="row g-3"> <!-- g-3 adds spacing between cards -->
        <div class="col-xl-3 col-lg-4 col-md-6 col-sm-12">
            <a href="/group/guest/injury-details" class="text-decoration-none">
                <div class="card p-3">
                    <div class="d-flex align-items-center">
                        <img src="<%=request.getContextPath()%>/images/injury.png" alt="">
                        <p class="mb-0"><liferay-ui:message key="injury" /></p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-xl-3 col-lg-4 col-md-6 col-sm-12">
            <a href="/group/guest/ms-screening-details" class="text-decoration-none">
                <div class="card p-3">
                    <div class="d-flex align-items-center">
                        <img src="<%=request.getContextPath()%>/images/screening.png" alt="">
                        <p class="mb-0"><liferay-ui:message key="ms-screening" /></p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-xl-3 col-lg-4 col-md-6 col-sm-12">
            <a href="/group/guest/history" class="text-decoration-none">
                <div class="card p-3">
                    <div class="d-flex align-items-center">
                        <img src="<%=request.getContextPath()%>/images/history.png" alt="">
                        <p class="mb-0"><liferay-ui:message key="history" /></p>
                    </div>
                </div>
            </a>
        </div>

        <div class="col-xl-3 col-lg-4 col-md-6 col-sm-12">
            <a href="/group/guest/exchnage" class="text-decoration-none">
                <div class="card p-3">
                    <div class="d-flex align-items-center">
                        <img src="<%=request.getContextPath()%>/images/exchange.png" alt="">
                        <p class="mb-0"><liferay-ui:message key="exchange-details" /></p>
                    </div>
                </div>
            </a>
        </div>
    </div>

</div>
