-- 각 테이블 출력
select * from LIB_MEMBER;           -- 회원 정보
select * from LIB_BOOK_INFO;        -- 도서 정보
select * from LIB_BOOK_RENTAL;      -- 대여 정보
-- 아래 테이블의 ID값을 기반으로 책 정보 속 코드(B_ID) 구성
select * from LIB_BOOK_GENRE;       -- 도서 장르
select * from LIB_BOOK_LIBRARY;     -- 도서관 정보
select * from LIB_BOOK_LANGUAGE;    -- 도서 언어

select b_id , b_title , b_rental_status 대출가능 from lib_book_info;
-- 대출 도서의 정보 가져오기
-- 도서 정보의 (B_ID) 값을 테이블의 코드를 기반으로 구성 해 두었음.
-- B_ID의 특정 코드 부분들을 SUBSTR로 가져와 해당 코드가 있는 코드 구성 테이블과 비교하여 출력
select r.rental_id 대출코드,I.b_id as "도서코드", I.b_title as "도서 제목"
     , I.b_author as "작가", G.g_name as "장르", 
       L.LAN_NAME as "언어",LI.L_name as "도서관"
from LIB_BOOK_INFO I
JOIN LIB_BOOK_LIBRARY LI
ON LI.L_ID = substr(I.B_ID,1,2)  -- 보유 도서관 출력
JOIN LIB_BOOK_GENRE G
ON G.G_ID = substr(I.B_ID,3,2)   -- 도서 장르 출력
JOIN LIB_BOOK_LANGUAGE L
ON L.LAN_ID = substr(I.B_ID,5,1) -- 도서 언어 출력
JOIN LIB_BOOK_RENTAL R
ON R.BOOK_ID = I.B_ID
order by r.rental_id;


-- 대여 정보의 값 중 반납 여부(RETURN_STATUS)가 미반납(N)인 경우
-- 도서 정보 테이블의 대여가능여부 열의 값을 'Y' -> 'N'으로 변경
UPDATE LIB_BOOK_INFO I
SET I.B_RENTAL_STATUS = 'N'         -- B_RENTAL_STATUS 컬럼의 값을 'N'으로 설정
WHERE I.B_RENTAL_STATUS ='Y'        -- 현재 대여 상태가 'Y'인 행을 대상
    AND EXISTS(                     -- 서브쿼리 사용
        SELECT 1                    -- 결과행 반환용. 값 의미 X
        FROM LIB_BOOK_RENTAL R      -- LIB_BOOK_RENTAL 조회
        WHERE I.B_ID = R.BOOK_ID    -- 현재 도서(I.B_ID)에 대해
        AND R.RETURN_STATUS = 'N'   -- 반납 상태가 'N'인 대여 기록이 존재하는지 확인
        );


-- 도서 반납 여부 수정
UPDATE LIB_BOOK_RENTAL
SET RETURN_STATUS = 'Y'     -- 반납 : 'Y' /  미반납 : 'N'
WHERE RENTAL_ID = 'R002' or RENTAL_ID = 'R001';   -- 해당 대여 코드(RENTAL_ID)


select rental_id 대출코드, return_status 반납여부 from lib_book_rental;

-- 대여 정보의 값 중 반납 여부(RETURN_STATUS)가 반납완료(Y)인 경우
-- 도서 정보 테이블의 대여가능여부 열의 값을 'N' -> 'Y'로 변경
UPDATE LIB_BOOK_INFO I
SET I.B_RENTAL_STATUS = 'Y'         -- B_RENTAL_STATUS 컬럼의 값을 'Y'으로 설정
WHERE I.B_RENTAL_STATUS ='N'        -- 현재 대여 상태가 'N'인 행을 대상
    AND EXISTS(                     -- 서브쿼리 사용
        SELECT 1                    -- 결과행 반환용. 값 의미 X
        FROM LIB_BOOK_RENTAL R      -- LIB_BOOK_RENTAL 조회
        WHERE I.B_ID = R.BOOK_ID    -- 현재 도서(I.B_ID)에 대해
        AND R.RETURN_STATUS = 'Y'   -- 반납 상태가 'Y'인 대여 기록이 존재하는지 확인
        );


-- 서적 대여시 회원 정보(LIB_MEMBER)속 대여가능 수량(M_RENTAL_LEFT)만큼 감소, 반납 시 반납 수 만큼 증가
UPDATE LIB_MEMBER M
SET M.M_RENTAL_LEFT = LEAST(    -- LEAST = 여러 값 중 가장 작은 값을 반환하여 M_RENTAL_LEFT 값이 3을 넘지 않음.
    3,
    M.M_RENTAL_LEFT 
    - (SELECT COUNT(*) 
       FROM LIB_BOOK_RENTAL R 
       WHERE R.MEMBER_ID = M.M_ID AND R.RETURN_STATUS = 'N')    -- 대여 테이블의 ID와 회원정보 테이블의 ID가 동일하고, 반납정보가 'N'인 경우 M_RENTAL_LEFT에서 - 처리
    + (SELECT COUNT(*)
       FROM LIB_BOOK_RENTAL R
       WHERE R.MEMBER_ID = M.M_ID AND R.RETURN_STATUS = 'Y')    -- 대여 테이블의 ID와 회원정보 테이블의 ID가 동일하고, 반납정보가 'N'인 경우 M_RENTAL_LEFT에서  처리
)
WHERE EXISTS (
    SELECT 1
    FROM LIB_BOOK_RENTAL R
    WHERE R.MEMBER_ID = M.M_ID AND (R.RETURN_STATUS = 'N' OR R.RETURN_STATUS = 'Y')
    -- 대여정보의 회원ID와 회원정보에서의 회원ID가 동일하고 대여정보의 반납정보가 'N'이거나 'Y'인 레코드를 찾기.
    -- 레코드 존재시 회원정보 행 업데이트, 없을 시 회원정보 행 업데이트 방지.
);





select r.rental_id 대출코드, I.b_title as "도서 제목"
     , i.b_rental_status 대출가능
from LIB_BOOK_INFO I
JOIN LIB_BOOK_LIBRARY LI
ON LI.L_ID = substr(I.B_ID,1,2)  -- 보유 도서관 출력
JOIN LIB_BOOK_GENRE G
ON G.G_ID = substr(I.B_ID,3,2)   -- 도서 장르 출력
JOIN LIB_BOOK_LANGUAGE L
ON L.LAN_ID = substr(I.B_ID,5,1) -- 도서 언어 출력
JOIN LIB_BOOK_RENTAL R
ON R.BOOK_ID = I.B_ID
order by r.rental_id;


select m_id 회원코드, m_name 회원이름, m_tel 전화번호, m_birthday 생년월일, m_rental_left 대출가능 from LIB_MEMBER; 