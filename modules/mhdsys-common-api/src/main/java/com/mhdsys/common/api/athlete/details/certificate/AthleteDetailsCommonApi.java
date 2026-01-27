package com.mhdsys.common.api.athlete.details.certificate;

import com.mhdsys.common.pojo.AthleteSportsCertificateDTO;
import com.mhdsys.schema.model.AthleteSportsCertificate;

public interface AthleteDetailsCommonApi {

	AthleteSportsCertificate saveAthleteDetails(AthleteSportsCertificateDTO athleteSportsCertificateDTO);

}
