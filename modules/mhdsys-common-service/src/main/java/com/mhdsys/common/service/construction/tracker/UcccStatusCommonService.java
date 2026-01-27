package com.mhdsys.common.service.construction.tracker;

import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.portal.kernel.bean.BeanPropertiesUtil;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.mhdsys.common.api.constructionTracker.ConstructionTrackerCommonApi;
import com.mhdsys.common.api.uccc.status.UcccStatusCommonApi;
import com.mhdsys.common.pojo.UcccStatusDTO;
import com.mhdsys.schema.model.UcccStatus;
import com.mhdsys.schema.service.UcccStatusLocalServiceUtil;

import org.osgi.service.component.annotations.Component;
@Component(immediate = true, service = UcccStatusCommonApi.class)
public class UcccStatusCommonService implements UcccStatusCommonApi {

    private static final Log _log = LogFactoryUtil.getLog(UcccStatusCommonService.class);

    @Override
    public UcccStatus saveUcccStatus(UcccStatusDTO ucccStatusDTO) {
        try {
            _log.info("UCCC STATUS SERVICE ::::::");

            if (ucccStatusDTO.getUcccId() > 0) {
                // --- UPDATE EXISTING RECORD ---
                _log.info("UPDATE / EDIT ::::::::::::");
                UcccStatus ucccStatus = UcccStatusLocalServiceUtil.getUcccStatus(ucccStatusDTO.getUcccId());

                long ucccId = ucccStatusDTO.getUcccId();
                _log.info("ucccId : " + ucccId);

                BeanPropertiesUtil.copyProperties(ucccStatusDTO, ucccStatus);
                ucccStatus.setUcccId(ucccId);

                return UcccStatusLocalServiceUtil.updateUcccStatus(ucccStatus);

            } else {
                // --- CREATE NEW RECORD ---
                UcccStatus ucccStatus = UcccStatusLocalServiceUtil.createUcccStatus(
                    CounterLocalServiceUtil.increment(UcccStatus.class.getName())
                );

                long ucccId = ucccStatus.getUcccId();
                _log.info("NEW UCCC STATUS ID : " + ucccId);

                BeanPropertiesUtil.copyProperties(ucccStatusDTO, ucccStatus);
                ucccStatus.setUcccId(ucccId);

                return UcccStatusLocalServiceUtil.addUcccStatus(ucccStatus);
            }

        } catch (Exception e) {
            _log.error(e.getMessage(), e);
            throw new RuntimeException("Failed to save UCCC Status", e);
        }
    }
}