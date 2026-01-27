package com.mhdsys.common.service.athlete.details.certificate;

import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.portal.kernel.bean.BeanPropertiesUtil;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.mhdsys.common.api.athlete.details.certificate.AthleteDetailsCommonApi;
import com.mhdsys.common.pojo.AthleteSportsCertificateDTO;
import com.mhdsys.schema.model.AthleteSportsCertificate;
import com.mhdsys.schema.service.AthleteSportsCertificateLocalServiceUtil;

import org.osgi.service.component.annotations.Component;

@Component(immediate = true, service = AthleteDetailsCommonApi.class)
public class AthleteDetailsCommonService implements AthleteDetailsCommonApi {

	private static final Log LOGGER = LogFactoryUtil.getLog(AthleteDetailsCommonService.class);

	@Override
	public AthleteSportsCertificate saveAthleteDetails(AthleteSportsCertificateDTO athleteSportsCertificateDTO) {

		try {
			LOGGER.info("ATHLETE CERTIFICATE DTO ::: " + athleteSportsCertificateDTO);

			if (athleteSportsCertificateDTO.getAthleteCertificateId() > 0) {

				LOGGER.info("UPDATE ATHLETE CERTIFICATE");

				AthleteSportsCertificate certificate = AthleteSportsCertificateLocalServiceUtil
						.getAthleteSportsCertificate(athleteSportsCertificateDTO.getAthleteCertificateId());

				long certificateId = certificate.getAthleteCertificateId();

				BeanPropertiesUtil.copyProperties(athleteSportsCertificateDTO, certificate);

				certificate.setAthleteCertificateId(certificateId);

				return AthleteSportsCertificateLocalServiceUtil.updateAthleteSportsCertificate(certificate);
			} else {

				LOGGER.info("ADD ATHLETE CERTIFICATE");

				AthleteSportsCertificate certificate = AthleteSportsCertificateLocalServiceUtil
						.createAthleteSportsCertificate(
								CounterLocalServiceUtil.increment(AthleteSportsCertificate.class.getName()));

				long certificateId = certificate.getAthleteCertificateId();

				BeanPropertiesUtil.copyProperties(athleteSportsCertificateDTO, certificate);

				certificate.setAthleteCertificateId(certificateId);

				return AthleteSportsCertificateLocalServiceUtil.addAthleteSportsCertificate(certificate);
			}

		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		}

		return null;
	}
}
