package com.mhdsys.common.api.uccc.status;

import com.mhdsys.common.pojo.UcccStatusDTO;
import com.mhdsys.schema.model.UcccStatus;

public interface UcccStatusCommonApi {
	UcccStatus saveUcccStatus(UcccStatusDTO ucccStatusDTO);
}
