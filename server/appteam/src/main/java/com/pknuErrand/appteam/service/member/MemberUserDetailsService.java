package com.pknuErrand.appteam.service.member;

import com.pknuErrand.appteam.domain.member.Member;
import com.pknuErrand.appteam.domain.member.MemberUserDetails;
import com.pknuErrand.appteam.dto.member.MemberUserDetailsDto;
import com.pknuErrand.appteam.repository.member.MemberRepository;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class MemberUserDetailsService implements UserDetailsService {

    private final MemberRepository memberRepository;

    public MemberUserDetailsService(MemberRepository memberRepository) {

        this.memberRepository = memberRepository;
    }

    @Override
    public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {

        // DB에서 조회
        Member member = memberRepository.findById(id);  // findByUsername

        MemberUserDetailsDto memberData = new MemberUserDetailsDto(
                member.getId(),
                member.getRole(),
                member.getPw()
        );

        if (memberData != null) {
            
            // UserDetails에 담아서 return하면 AuthenticationManager가 검증 함
            return new MemberUserDetails(memberData);
        }

        return null;
    }
}
