#BEFORE RUNNING THIS TEST CHANGE IE SECURITY SETTING to ensure Protected MODE is enabled FOR INTERNET, LOCAL INTRANET, TRUSTED SITE, RESTRICTED SITE
# AND ZOOM LEVEL IS SET TO 100%
#
#
#module with class and function to find the outlier in a given array
module Puzzle
  class HandArrays
    #function find the function to find the outlier in a given array
    def findOutlier(*array)
#select all even numbers
      even = array.select {|num| num.even?}
      #select all even numbers
      odd = array.select {|num| num.odd?}
      #Conditional statement to find outlier number
      if even.count> odd.count
        return odd
      else
        return even
      end
    end
  end
end


#calling selenium webdriver
  require 'selenium-webdriver'

#calling Internet Explorer driver
  driver = Selenium::WebDriver.for :ie

#maximize browser
  driver.manage.window.maximize

#opening  WAUT
  driver.get "http://demoqa.com/"

#click on tabs 1 to 5
  driver.find_element(:xpath, "//*[@id='ui-id-1']").click
  driver.find_element(:xpath, "//*[@id='ui-id-2']").click
  driver.find_element(:xpath, "//*[@id='ui-id-3']").click
  driver.find_element(:xpath, "//*[@id='ui-id-4']").click
  driver.find_element(:xpath, "//*[@id='ui-id-5']").click
#storing title of tab 3
  tabThreeTitle = driver.find_element(:xpath, "//*[@id='ui-id-3']").text

#storing title of tab 5
  tabFiveTitle = driver.find_element(:xpath, "//*[@id='ui-id-5']").text


#click on Demo dropdown menu
  driver.find_element(:css, "#menu-item-66 > a").click

# click on Tabs menu under Demo menu
  driver.find_element(:link, "Tabs").click
# click on Registration button
  driver.find_element(:link, "Registration").click
# fill FirstName field using previously stored variable above
 sleep 10
  driver.find_element(:name, "first_name").send_keys(tabThreeTitle)
# fill LastName field using previously stored variable above
  driver.find_element(:name, "last_name").send_keys(tabFiveTitle)
# click on married radio button
  driver.find_element(:xpath, "//input[@value='married']").click
# click on cricket radio button
  driver.find_element(:xpath, "//input[contains(@value,'cricket')]").click
# click on Country dropdown and select Austria by Value
  driver.find_element(:xpath, "//*[@id='dropdown_7']").find_element(:css, "option[value='Austria']").click

# click on Month dropdown and select 5th month by Index
  driver.find_element(:id, "mm_date_8").find_element(:css, "option:nth-child(6)").click
# click on Day dropdown and select 21
  driver.find_element(:name, "date_8[date][dd]").find_element(:css, "option[value='21']").click
# ciick on Year dropdown and select 1992
  driver.find_element(:xpath, "//*[@id='yy_date_8']").find_element(:css, "option[value='1992']").click
# enter phone number
  driver.find_element(:name, "phone_9").send_keys("09119119111")
#generating random string for username and email id

random_string = ([*('A'..'Z'),*('0'..'9')]-%w(0 1 I O)).sample(8).join

x = rand(10000)

# enter username
driver.find_element(:name, "username").send_keys(random_string + x.to_s)

# enter email id
driver.find_element(:name, "e_mail").send_keys(random_string+ x.to_s + "@horizon.com")
# this website is not accepting any file type so I have commented the test step below
# upload profile picture
#driver.find_element(:name, "profile_pic_10").send_keys("C:\\022.JPG")


#calling puzzle.rb function to find the outlier in the given arrays
outputSecondArray= Puzzle::HandArrays.new
numberTwo= outputSecondArray.findOutlier(160, 3, 1719, 19, 11, 13, -21)

numberOne= outputSecondArray.findOutlier(22, 24, 0, 100, 4, 111, 2602, 18)
# enter text in About Yourself field
  driver.find_element(:xpath, "//textarea[@id='description']").send_keys("I am Software tester"+numberTwo.to_s+numberOne.to_s)


# enter password
  driver.find_element(:css, "#password_2").send_keys("performance@horizon.com")

# enter confirm password
  driver.find_element(:css, "#confirm_password_password_2").send_keys("performance@horizon.com")

# click on Submit button
  driver.find_element(:name, "pie_submit").click

# capture confirmation message following submission of registration page
  confirmationMsg = driver.find_element(:xpath, "//*[@id='post-49']/div/p").text

  if (confirmationMsg == "Thank you for your registration")
    puts "Registration is successful"
  else
    Dir.mkdir "C:\\screenshots"
    driver.save_screenshot("C:\\screenshots\\screenshot.png")
  end
  driver.close



