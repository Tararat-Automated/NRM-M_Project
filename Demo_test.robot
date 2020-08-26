*** Settings ***
Library           AppiumLibrary
Resource         ../Poc_Dtac/Resource/PageKeywords/LoginwithFacebook_PageKeyword.robot

*** Variables ***
${REMOTE_URL}     http://localhost:4723/wd/hub      # URL to appium server
${PLATFORM_NAME}    Android   #Android    #iOS
${PLATFORM_VERSION}   9   #8.0.0   #12.4.8   #13.5
${DEVICE_NAME}    emulator01   #Galaxy S7   #Galaxy S7  #iPhone 6_test
#Appium uses the *.app directory that is created by the ios build to provision the emulator.
${APP_LOCATION}     ../ProjectIOS/build/Build/Products/Debug-iphonesimulator/ProjectIOS.app
${BUNDLE_ID}         com.onionshack.ProjectDemo
${APP_PACKAGE}    com.onionshack.projectdemo
${APP_ACTIVITY}       com.onionshack.projectdemo.MainActivity
${txtbutton}     xpath=//android.widget.Button[contains(@resource-id,'btnTest')]    #id=com.onionshack.projectdemo:id/btnTest
${txtbutton_ios}      xpath=//XCUIElementTypeButton[@name="DTAC"]
${txtDtac}     DTAC
${PLATFORM}     ${ar_OS}

*** Keywords ***
Android Open app
     Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    platformVersion=${PLATFORM_VERSION}    deviceName=${DEVICE_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}

iOS Open App     
     Open Application    ${REMOTE_URL}    platformName=${PLATFORM_NAME}    platformVersion=13.5
      ...    deviceName=B13DAB82-673C-428E-87F1-24A31042DC0F      app=${APP_LOCATION}     #automationName=appium   

Verify text button
     Run Keyword If    "${PLATFORM}"=="Android"    Element Text Should Be      ${txtbutton}      ${txtDtac}
     ...    ELSE IF     "${PLATFORM}"=="iOS"   Element Text Should Be      ${txtbutton_ios}      ${txtDtac}

Close All Apps
     Capture Page Screenshot
     Close All Applications

Open App 
     Run Keyword If    "${PLATFORM}"=="Android"    Android Open app
     ...    ELSE IF     "${PLATFORM}"=="iOS"   iOS Open App

*** Test Cases ***
test_demo
     Open App 
     Verify text button
     Close All Apps