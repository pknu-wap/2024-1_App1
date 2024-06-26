package com.pknuErrand.appteam.domain.member;

import com.pknuErrand.appteam.dto.member.MemberUserDetailsDto;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.ArrayList;
import java.util.Collection;

public class MemberUserDetails implements UserDetails {

    private final MemberUserDetailsDto memberUserDetailsDto;

    public MemberUserDetails(MemberUserDetailsDto memberUserDetailsDto) {

        this.memberUserDetailsDto = memberUserDetailsDto;

    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {

        Collection<GrantedAuthority> collection = new ArrayList<>();

        collection.add(new GrantedAuthority() {

            @Override
            public String getAuthority() {

                return memberUserDetailsDto.getRole();
            }
        });

        return collection;
    }

    @Override
    public String getPassword() {

        return memberUserDetailsDto.getPw();
    }

    @Override
    public String getUsername() {

        return String.valueOf(memberUserDetailsDto.getId());
    }

    @Override
    public boolean isAccountNonExpired() {

        return true;
    }

    @Override
    public boolean isAccountNonLocked() {

        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {

        return true;
    }

    @Override
    public boolean isEnabled() {
        
        return true;
    }
}
