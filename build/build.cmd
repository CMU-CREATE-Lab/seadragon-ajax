@echo off

:: Got this from http://stackoverflow.com/a/203116
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2% %ldt:~8,2%:%ldt:~10,2%:%ldt:~12,6%

echo /*! > seadragon-header.js
echo  * Seadragon Ajax 0.8.9 (custom build from source on %ldt%) >> seadragon-header.js
echo  * CREATE Lab fork: https://github.com/CMU-CREATE-Lab/seadragon-ajax >> seadragon-header.js
echo  * http://gallery.expression.microsoft.com/SeadragonAjax >> seadragon-header.js
echo  * This code is distributed under the license agreement at: >> seadragon-header.js
echo  * http://go.microsoft.com/fwlink/?LinkId=164943 >> seadragon-header.js
echo  */ >> seadragon-header.js

type ..\src\_intro.txt > seadragon-code.js

for %%f in (
  Seadragon.Core.js
  Seadragon.Config.js
  Seadragon.Strings.js
  Seadragon.Debug.js
  Seadragon.Profiler.js
  Seadragon.Point.js
  Seadragon.Rect.js
  Seadragon.Spring.js
  Seadragon.Utils.js
  Seadragon.MouseTracker.js
  Seadragon.EventManager.js
  Seadragon.ImageLoader.js
  Seadragon.Buttons.js
  Seadragon.TileSource.js
  Seadragon.DisplayRect.js
  Seadragon.DeepZoom.js
  Seadragon.Viewport.js
  Seadragon.Drawer.js
  Seadragon.Viewer.js
) do (
  echo.
  echo // %%f:
  echo.
  type ..\src\%%f
) >> seadragon-code.js

type ..\src\_outro.txt >> seadragon-code.js

:: Create a non-minified version
type seadragon-header.js > seadragon.js
type seadragon-code.js >> seadragon.js

:: Create the minified version
type seadragon-header.js > seadragon-min.js
ajaxmin.exe /Z /HC seadragon-code.js >> seadragon-min.js

del seadragon-header.js
del seadragon-code.js