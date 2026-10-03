@echo off
:: Włączenie obsługi polskich znaków (UTF-8)
chcp 65001 > nul
title Super Klikacz UTF-8 v1.0
mode con: cols=60 lines=22
color 0B

:: Statystyki początkowe
set /a punkty=0
set /a punkty_za_klik=1
set /a auto_klikacze=0

:: Koszty ulepszeń
set /a koszt_klika=15
set /a koszt_auto=50

:ekran_glowny
cls
set /a dochod_auto=%auto_klikacze% * 2
echo ====================================================
echo                SUPER KLIKACZ UTF-8
echo ====================================================
echo.
echo    Twoje punkty:       %punkty% 💰
echo    Punkty za klik:     %punkty_za_klik% 📈
echo    Auto-klikacze:      %auto_klikacze% 🤖 (Generują: +%dochod_auto%/sek)
echo.
echo ====================================================
echo Opcje:
echo [K] - KLIKNIJ (Zdobądź punkty)
echo [1] - Ulepsz klik (+1/klik)     ^| Koszt: %koszt_klika% pkt
echo [2] - Kup Auto-klikacza (+2/sek) ^| Koszt: %koszt_auto% pkt
echo [R] - Zbierz z auto-klikaczy (Odśwież)
echo [X] - Wyjście z gry
echo ====================================================
echo.

:: Jeśli posiadasz auto-klikacze, gra nalicza punkty przy każdym odświeżeniu ekranu
if %auto_klikacze% GTR 0 (
    set /a punkty=%punkty% + %dochod_auto%
)

choice /c k12rx /n /m "Wybierz opcję z nawiasu: "

if errorlevel 5 goto koniec
if errorlevel 4 goto ekran_glowny
if errorlevel 3 goto kup_auto
if errorlevel 2 goto ulepsz_klik
if errorlevel 1 goto kliknij
goto ekran_glowny

:kliknij
set /a punkty=%punkty% + %punkty_za_klik%
goto ekran_glowny

:ulepsz_klik
if %punkty% LSS %koszt_klika% (
    echo.
    echo [!] Masz za mało punktów!
    timeout /t 1 > nul
    goto ekran_glowny
)
set /a punkty=%punkty% - %koszt_klika%
set /a punkty_za_klik=%punkty_za_klik% + 1
set /a koszt_klika=%koszt_klika% * 2
goto ekran_glowny

:kup_auto
if %punkty% LSS %koszt_auto% (
    echo.
    echo [!] Masz za mało punktów!
    timeout /t 1 > nul
    goto ekran_glowny
)
set /a punkty=%punkty% - %koszt_auto%
set /a auto_klikacze=%auto_klikacze% + 1
set /a koszt_auto=%koszt_auto% * 2 + 10
goto ekran_glowny

:koniec
cls
echo Dziękujemy za grę! Twój wynik końcowy to %punkty% punktów.
timeout /t 2 > nul
exit
