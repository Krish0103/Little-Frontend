package com.swiggaa.frontend.config;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class WebClientConfig {

    private static final String GATEWAY_BASE_URL = "http://localhost:8080";

    @Bean
    @Qualifier("authServiceWebClient")
    public WebClient authServiceWebClient() {
        return WebClient.builder()
                .baseUrl(GATEWAY_BASE_URL)
                .build();
    }

    @Bean
    @Qualifier("menuServiceWebClient")
    public WebClient menuServiceWebClient() {
        return WebClient.builder()
                .baseUrl(GATEWAY_BASE_URL)
                .build();
    }

    @Bean
    @Qualifier("orderServiceWebClient")
    public WebClient orderServiceWebClient() {
        return WebClient.builder()
                .baseUrl(GATEWAY_BASE_URL)
                .build();
    }
}