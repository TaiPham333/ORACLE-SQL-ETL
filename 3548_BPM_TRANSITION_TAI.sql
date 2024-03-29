SELECT DISTINCT 
		DATA_DATE
		, ID_GIAO_DICH
		, MA_GIAO_DICH 
		, TEN_KHACH_HANG
		, CIF_KHACH_HANG
		, NGAY_HOAN_THANH
		, DON_VI
		, KHU_VUC
		, SO_TIEN_PHE_DUYET
		, TEN_SAN_PHAM
		, LOAI_NGOAI_LE 
		, CHI_TIET_NGOAI_LE 
		, LUONG_ORG
		FROM
(SELECT 
		trunc(sysdate) AS DATA_DATE
		, fbe.AP_ID AS ID_GIAO_DICH
		, fbe.MA_GIAO_DICH
		, fba.CST_NM AS TEN_KHACH_HANG
		, fba.CST_NBR AS CIF_KHACH_HANG
		, fba.END_DT AS NGAY_HOAN_THANH 
		, fba.BR_CODE AS DON_VI 
		, fba.REGION AS KHU_VUC
		, dba.APRV_AMT AS SO_TIEN_PHE_DUYET
		, dba.BPM_PD_ID AS TEN_SAN_PHAM		
		, INITCAP(fbe.EXPC_TP) AS LOAI_NGOAI_LE 
		, fbe.EXPC_DTL AS CHI_TIET_NGOAI_LE
		, fba1.TXN_TP_ID AS LUONG_ORG
		FROM TCIMPORT.FACT_BPM_EXCEPTION fbe
LEFT JOIN
	(SELECT 
		AP_NBR
		, UPPER(CST_NM) CST_NM
		, REGEXP_SUBSTR(CST_NBR,'[^-]+',1,2) CST_NBR
		, END_DT
		, BR_CODE
		, REGION
		FROM TCIMPORT.FACT_BPM_APPLICATION) fba 
ON fbe.MA_GIAO_DICH = fba.AP_NBR
LEFT JOIN 
	(SELECT 
		AP_NBR
		, TXN_TP_ID
		FROM TCIMPORT.FACT_BPM_APPLICATION
		WHERE AP_TP = 'GDK') fba1 
ON fbe.MA_GIAO_DICH = fba1.AP_NBR 
LEFT JOIN
	(SELECT 
		AP_NBR
		, BPM_PD_ID
		, APRV_AMT 
		FROM TCIMPORT.DIM_BPM_AP_PRODUCT WHERE
		(trunc(sysdate-1) BETWEEN EFF_FM_DT  AND nvl(EFF_TO_DT,TO_DATE(24000101,'yyyymmdd')))) dba
ON fbe.MA_GIAO_DICH = dba.AP_NBR);

---------
--Version 2
--		DATA_DATE
--		, ID_GIAO_DICH
--		, MA_GIAO_DICH 
--		, TEN_KHACH_HANG
--		, CIF_KHACH_HANG
--		, NGAY_HOAN_THANH
--		, DON_VI
--		, KHU_VUC
--		, SO_TIEN_PHE_DUYET
--		, TEN_SAN_PHAM
--		, LOAI_NGOAI_LE 
--		, CHI_TIET_NGOAI_LE 
--		, LUONG_ORG
-----
--		trunc(sysdate) AS DATA_DATE
--		, fbe.AP_ID AS ID_GIAO_DICH
--		, fbe.MA_GIAO_DICH
--		, fba.CST_NM AS TEN_KHACH_HANG
--		, fba.CST_NBR AS CIF_KHACH_HANG
--		, fba.END_DT AS NGAY_HOAN_THANH 
--		, fba.BR_CODE AS DON_VI 
--		, fba.REGION AS KHU_VUC
--		, dba.APRV_AMT AS SO_TIEN_PHE_DUYET
--		, dba.BPM_PD_ID AS TEN_SAN_PHAM		
--		, INITCAP(fbe.EXPC_TP) AS LOAI_NGOAI_LE 
--		, fbe.EXPC_DTL AS CHI_TIET_NGOAI_LE
--		, fba1.TXN_TP_ID AS LUONG_ORG

WITH fbe AS 
(SELECT * 
		FROM TCIMPORT.FACT_BPM_EXCEPTION)
, fba AS 
(SELECT 
		AP_NBR
		, UPPER(CST_NM) CST_NM
		, REGEXP_SUBSTR(CST_NBR,'[^-]+',1,2) CST_NBR
		, END_DT
		, BR_CODE
		, REGION
		FROM TCIMPORT.FACT_BPM_APPLICATION)
, fba1 AS 
	(SELECT 
		AP_NBR
		, TXN_TP_ID
		FROM TCIMPORT.FACT_BPM_APPLICATION
		WHERE AP_TP = 'GDK')
, dba AS
	(SELECT 
		AP_NBR
		, BPM_PD_ID
		, APRV_AMT 
		FROM TCIMPORT.DIM_BPM_AP_PRODUCT WHERE
		(trunc(sysdate-1) BETWEEN EFF_FM_DT  AND nvl(EFF_TO_DT,TO_DATE(24000101,'yyyymmdd'))))
SELECT DISTINCT 
		DATA_DATE
		, ID_GIAO_DICH
		, MA_GIAO_DICH 
		, TEN_KHACH_HANG
		, CIF_KHACH_HANG
		, NGAY_HOAN_THANH
		, DON_VI
		, KHU_VUC
		, SO_TIEN_PHE_DUYET
		, TEN_SAN_PHAM
		, LOAI_NGOAI_LE 
		, CHI_TIET_NGOAI_LE 
		, LUONG_ORG
		FROM
		(SELECT 
		trunc(sysdate) AS DATA_DATE
		, fbe.AP_ID AS ID_GIAO_DICH
		, fbe.MA_GIAO_DICH
		, fba.CST_NM AS TEN_KHACH_HANG
		, fba.CST_NBR AS CIF_KHACH_HANG
		, fba.END_DT AS NGAY_HOAN_THANH 
		, fba.BR_CODE AS DON_VI 
		, fba.REGION AS KHU_VUC
		, dba.APRV_AMT AS SO_TIEN_PHE_DUYET
		, dba.BPM_PD_ID AS TEN_SAN_PHAM		
		, INITCAP(fbe.EXPC_TP) AS LOAI_NGOAI_LE 
		, fbe.EXPC_DTL AS CHI_TIET_NGOAI_LE
		, fba1.TXN_TP_ID AS LUONG_ORG
		FROM fbe 
		LEFT JOIN fba 
		ON fbe.MA_GIAO_DICH = fba.AP_NBR 
		LEFT JOIN fba1 
		ON fbe.MA_GIAO_DICH = fba1.AP_NBR
		LEFT JOIN dba 
		ON fbe.MA_GIAO_DICH = dba.AP_NBR);


