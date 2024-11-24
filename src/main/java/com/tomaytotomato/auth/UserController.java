package com.tomaytotomato.auth;

import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationToken;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

@RestController
public class UserController {

    @GetMapping("/user")
    public Map<String, Object> user(JwtAuthenticationToken principal) {
        return Map.of(
            "name", principal.getName(),
            "attributes", principal.getTokenAttributes()
        );
    }
}