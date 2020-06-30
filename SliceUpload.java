package com.huawei.utils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.RandomAccessFile;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xlightweb.BodyDataSource;

import com.huawei.af.util.Utils;
import com.huawei.core.HttpClientConfig;
import com.huawei.service.basic.Common;

/**
 * 分片上传文件工具类
 * 
 * @author zWX241296 2019年8月19日11:14:14
 * @version v1.0
 *
 */
public class SliceUpload {
	static final Logger logger = LoggerFactory.getLogger(SliceUpload.class);

	static long shardSize = 1900000;

	public static String simuDataUpload(String path, String dataName, String id, String cpeHeight, String rat) {
		String url = HttpClientConfig.urlCommon + Common.ins.getProperty("wttx.simulated.data.import.url");
        String referer = HttpClientConfig.urlCommon + Common.ins.getProperty("wttx.simulated.data.import.referer");
		File file = new File(path);
		if (!file.exists()) {
			logger.error("file not found: {}", path);
			return "";
		} else {
			long fileSize = file.length();
			long shardCount = 0 == file.length() % shardSize ? file.length() / shardSize
					: file.length() / shardSize + 1;

			String fileTag = java.util.UUID.randomUUID().toString();
			for (int i = 0; i < shardCount; ++i) {
				long start = i * shardSize;
				long end = Math.min(fileSize, start + shardSize);
				Map<String, Object> plainFormData = new HashMap<>();
				plainFormData.put("fileName", dataName + ".csv");
				plainFormData.put("fileCount", shardCount);
				plainFormData.put("fileIndex", i + 1);
				plainFormData.put("fileTag", fileTag);
				plainFormData.put("roarand", HttpClientConfig.random);
				File sliceFile = slice(path, start, end);
				BodyDataSource body = XlightWeb.multiPartRequest(url, referer, plainFormData, sliceFile, "inputName");
				logger.info(body.toString());
				try {
					body.close();
				} catch (IOException e) {
					logger.error("", e);
				}
				sliceFile.delete();
			}
			
			Map<String, Object> plainFormData = new HashMap<>();
			plainFormData.put("fileName", dataName + ".csv");
			plainFormData.put("fileCount", String.valueOf(shardCount));
			plainFormData.put("fileIndex", "-1");
			plainFormData.put("fileTag", fileTag);
			plainFormData.put("roarand", HttpClientConfig.random);
			plainFormData.put("cpeHeight", cpeHeight);
			plainFormData.put("dataId", id);
			plainFormData.put("dataName", dataName);
			plainFormData.put("rat", rat);
			
			BodyDataSource result = XlightWeb.multiPartRequest(url, referer, plainFormData);
			logger.info(result.toString());
			return result.toString();
		}
	}

	private static File slice(String source, long start, long end) {
		File file = new File( Utils.getCodePath() + "\\config\\tmp\\" + System.currentTimeMillis() + ".tmp" );
		try (RandomAccessFile in = new RandomAccessFile(new File(source), "r");
				FileOutputStream out = new FileOutputStream(file);){
			in.seek(start);
			int n = 0;
			byte[] b = new byte[1024];
			while ((n = in.read(b)) != -1 && in.getFilePointer() <= end) {
				out.write(b, 0, n);
			}
			return file;
		} catch (Exception e) {
			logger.error("", e);
		} 

		return null;
	}
}
