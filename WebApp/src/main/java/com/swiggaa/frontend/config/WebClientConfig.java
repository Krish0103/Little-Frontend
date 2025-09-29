package com.swiggaa.frontend.config;

import java.time.Duration;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.client.reactive.ReactorClientHttpConnector;
import org.springframework.web.reactive.function.client.WebClient;

import reactor.netty.http.client.HttpClient;

@Configuration
public class WebClientConfig {

    private static final String GATEWAY_BASE_URL = "http://localhost:8080";

    private WebClient.Builder createWebClientBuilder() {
        HttpClient httpClient = HttpClient.create()
                .responseTimeout(Duration.ofSeconds(30))
                .followRedirect(true);

        return WebClient.builder()
                .baseUrl(GATEWAY_BASE_URL)
                .clientConnector(new ReactorClientHttpConnector(httpClient))
                .codecs(configurer -> configurer.defaultCodecs().maxInMemorySize(1024 * 1024)); // 1MB
    }

    @Bean
    @Qualifier("authServiceWebClient")
    public WebClient authServiceWebClient() {
        return createWebClientBuilder().build();
    }

    @Bean
    @Qualifier("menuServiceWebClient")
    public WebClient menuServiceWebClient() {
        return createWebClientBuilder().build();
    }

    @Bean
    @Qualifier("orderServiceWebClient")
    public WebClient orderServiceWebClient() {
        return createWebClientBuilder().build();
    }
}