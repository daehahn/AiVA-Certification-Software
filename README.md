## Certification software for AiVA (FCC, IC, CE)

이 소프트웨어는 AiVA 보드 인증을 위해 만들어졌습니다.

---
### 설치
* 다음 명령들을 순차적으로 실행하면 인증용 소프트웨어가 설치됩니다. (약 2~3시간 소료됩니다.)
```
$ git clone https://github.com/roykang75/AiVA-Cert-SW.git
$ cd AiVA-Cert-SW
$ chmod +x automated_install.sh
$ ./automated_install.sh
```

* 설치가 완료된 후, console을 실행하면 아래와 같은 화면이 나타납니다.
![](/assert/test_menu.png)

### 메뉴 설명
1. AiVA Full Test  
: Google Assistant와 Zigbee 통신이 동시에 실행 됩니다.
  AiVA 보드의 마이크, 스피커 및 노이즈 캔슬레이션 등의 기능이 수행되며, 동시에 UART 통신도 실행합니다.
  AiVA 보드의 모든 기능을 동시에 실행할 때 사용하는 메뉴입니다.

2. Buddy Setup
: AiVA 보드와 통신할 Buddy 보드를 위한 메뉴입니다. (Raspberry Pi3용으로 구현됨)
  "안녕"이라는 음성과 AiVA 보드 Zigbee 모듈로 부터온 데이터를 loopback으로 다시 보내주는 일을 수행합니다.

3. Run Google Assistant (Korean)
: 구글 어시스턴트 한국어 모드를 실행합니다.

4. Run Google Assistant (English)
: 구글 어시스턴트 영어 모드를 실행합니다.

5. UART Communication
: Zigbee 통신만 개별적으로 실행할 때 사용합니다.

6. Sound Pressure Test
: 음압 테스트를 위해 1KHz 음원을 재생합니다.

7. Soung Hi Message
: 한국어로 "안녕" 음원을 무한 반복하여 재생합니다.

8. Quit
: 테스트를 종료합니다.

