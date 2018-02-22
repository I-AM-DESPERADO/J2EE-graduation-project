package com.pzy.jcook.workflow.service.nofy;

import java.io.IOException;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.time.DateFormatUtils;
import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.pzy.jcook.sys.entity.User;

@Service("WeixinNofyService")
public class WeixinNofyService implements NofyService {

	private static final Logger log = LoggerFactory.getLogger(WeixinNofyService.class);

	@Value("${spring.weixin.appid}")
	private String appid;

	@Value("${spring.weixin.secret}")
	private String secret;

	@Value("${spring.weixin.template_id}")
	private String templateid;

	public static final String WEIXIN_GETTOOKEN_URL = "https://api.weixin.qq.com/cgi-bin/token";

	public static final String WEIXIN_TEMPLATE_MSG_URL = "https://api.weixin.qq.com/cgi-bin/message/template/send?access_token=";

	/***
	 * 这部分操作比较耗时，异步执行
	 */
	@Override
	@Async
	public void send(Map<String, Object> map) throws IOException {
		log.info("send weixin msg to{}", map.get("username"));
		CloseableHttpClient client = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(WEIXIN_TEMPLATE_MSG_URL + getTokenKey());
		httpPost.setEntity(new StringEntity(createMsgBody(map), Charset.forName("UTF-8")));
		CloseableHttpResponse response = client.execute(httpPost);
		HttpEntity entity = response.getEntity();
		String responsebody = EntityUtils.toString(entity);
		EntityUtils.consume(entity);
		response.close();
		log.info("send weixin msg-response>{}", responsebody);
	}

	private String getTokenKey() throws IOException {
		CloseableHttpClient client = HttpClients.createDefault();
		HttpPost httpPost = new HttpPost(WEIXIN_GETTOOKEN_URL);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		nvps.add(new BasicNameValuePair("appid", appid));
		nvps.add(new BasicNameValuePair("secret", secret));
		nvps.add(new BasicNameValuePair("grant_type", "client_credential"));
		httpPost.setEntity(new UrlEncodedFormEntity(nvps));
		CloseableHttpResponse response = client.execute(httpPost);
		HttpEntity entity = response.getEntity();
		String responsebody = EntityUtils.toString(entity);
		log.info("send weixin getTokenKey-- {}", responsebody);
		EntityUtils.consume(entity);
		response.close();
		@SuppressWarnings("unchecked")
		Map<String, String> map = new Gson().fromJson(responsebody, Map.class);
		return map.get("access_token");
	}

	private String createMsgBody(Map<String, Object> map) {
		User user = (User) map.get("user");
		WeixinTemplateMsg msg = new WeixinTemplateMsg(user.getOpenid(), templateid, "");
		msg.getData().put("first", new MsgItem((String) map.get("username"), "#444"));
		msg.getData().put("keyword1", new MsgItem("您有一条任务等待处理(" + (String) map.get("taskname") + ")", "#444"));
		msg.getData().put("keyword2", new MsgItem(DateFormatUtils.format(new Date(), "MM月mm日HH:mm"), "#444"));
		msg.getData().put("remark", new MsgItem("请及时处理", "#444"));
		return new Gson().toJson(msg);
	}

}
