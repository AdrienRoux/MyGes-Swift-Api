# MyGes-Swift-Api


This package is a wrapper for the MyGES api written in Swift, it can be used in Swift and SwiftUI.

- [Features](#features)
- [Basic Usage](#basic-usage)
- [Use Cases](#use-cases)
- [Installation](#installation)
- [Contributing](#contributing)
- [License](#license)


## Features

* Try an username-password pair login
* Get all years spent in school or just the last one
* Get profile
* Get planning / agenda
* Get Absences
* Get all grades
* Get courses
* Get projects or just a single one
* Get next project steps
* Join / leave a project group
* Get the real link to the profile picture


## Basic Usage

Using `MyGes` Api is as easy as:

```swift
import MyGes

MyGes.credentials = Credentials(username: "myges_username", password: "myges_password")

MyGes.getAbsences { result in
    print(result)
}
```

So you basically import the module where you want ot use it and and all the calls to the API are async so there is a completion handler.


## Use Cases

The following aspects of ```MyGes``` Api can be used:

* ```func MyGes.login()``` 

    Can be used to chain calls to a login call creating an short-life token used to make requests.
    > (not necessary for any requests in the wrapper)
    
    * **Parameters**
        - ```_ credentials``` *(Optional)* : Option to change the saved credentials for any requests at wrapper-level - ```Credentials```.
        - ```saveCredentials``` *(Optional)* : Option to save the credentials in UserDefaults for later use. ```Bool``` - defaults to false
    * **Returns** 
        - *async* (```MyGes.APIError?```) - In case of success, ```nil``` is returned, if any error is raised during the login process, an ```APIError``` will be returned.
        
        
* ```func MyGes.getYears()```
    
    Can be used to get all years spent in the school for a student.

    * **Returns**
        - *async* (```[Int]?```) - In case of success an array of years ```[Int]``` is returned, in any case of error due to network, login, or api issue, ```nil``` is returned.
    
    
* ```func MyGes.getLastYear()```
    
    Can be used to get the last year the student spent in school.

    * **Returns**
        - *async* (```Int?```) - In case of success, the last year as an ```Int``` is returned, in any case of error due to network, login, or api issue, ```nil``` is returned.
    
    
* ```func MyGes.getProfile()```
    
    Can be used to get the profile of a student.

    * **Returns**
        - *async* (```ProfileItem?```) - In case of success, the profile of the student is returned as a ```ProfileItem```, in any case of error due to network, login, or api issue, ```nil``` is returned.
        

* ```func MyGes.getAgenda()```
    
    Can be used to get the courses times, rooms, etc... of a student in a specific time period.

    * **Parameters**
        - ```startDate``` : The start of the period to search for courses, as a ```Date``` object.
        - ```endDate``` : The end of the period to search for courses, as a ```Date``` object.
    * **Returns**
        - *async* (```[AgendaItem]?```) - In case of success, an array of courses is returned as a ```[AgendaItem]```, in any case of error due to network, login, or api issue, ```nil``` is returned.
        

* ```func MyGes.getAbsences()```
    
    Can be used to get the absences of a student over an entire year.

    * **Parameters**
        - ```year``` *(optional)* : A specific year can be used to override default behavior using the last year spent in school by the student - ```Int```, defaults to ```nil```
    * **Returns**
        - *async* (```[AbsenceItem]?```) - In case of success, an array of absences is returned as a ```[AbsenceItem]```, in any case of error due to network, login, or api issue, ```nil``` is returned.
        
        
* ```func MyGes.getGrades()```
    
    Can be used to get the grades of a student over an entire year.

    * **Parameters**
        - ```year``` *(optional)* : A specific year can be used to override default behavior using the last year spent in school by the student - ```Int```, defaults to ```nil```
    * **Returns**
        - *async* (```[GradeItem]?```) - In case of success, an array of grades is returned as a ```[GradeItem]```, in any case of error due to network, login, or api issue, ```nil``` is returned.
        
        
* ```func MyGes.getCourses()```
    
    Can be used to get the courses dispensed to a student over an entire year.

    * **Parameters**
        - ```year``` *(optional)* : A specific year can be used to override default behavior using the last year spent in school by the student - ```Int```, defaults to ```nil```
    * **Returns**
        - *async* (```[CourseItem]?```) - In case of success, an array of courses is returned as a ```[CourseItem]```, in any case of error due to network, login, or api issue, ```nil``` is returned.
    

* ```func MyGes.getProjects()```
    
    Can be used to get all of a student projects over an entire year.

    * **Parameters**
        - ```year``` *(optional)* : A specific year can be used to override default behavior using the last year spent in school by the student - ```Int```, defaults to ```nil```
    * **Returns**
        - *async* (```[ProjectItem]?```) - In case of success, an array of projects is returned as a ```[ProjectItem]```, in any case of error due to network, login, or api issue, ```nil``` is returned.
      
      
* ```func MyGes.getProject()```
    
    Can be used to get a specific project for a student.

    * **Parameters**
        - ```id``` : The id of the searched project as an ```Int```
    * **Returns**
        - *async* (```ProjectItem?```) - In case of success, a project is returned as a ```ProjectItem```, in any case of error due to network, login, or api issue, ```nil``` is returned.
        

* ```func MyGes.getNextProjectSteps()```
    
    Can be used to get the upcoming project steps of a student.

    * **Returns**
        - *async* (```[ProjectStepItem]?```) - In case of success, student's upcoming steps are returned as a ```[ProjectStepItem]```, in any case of error due to network, login, or api issue, ```nil``` is returned.    
        
        
* ```func MyGes.joinProjectGroup()```
    
    Can be used to join a group in a specific project.

    * **Parameters**
        - ```_ projectRcId``` : The ```project_rc_id``` of the project as an ```Int```
        - ```_ projectId``` : The ```project_id``` of the project as an ```Int```
        - ```_ projectGroupId``` : The ```project_group_id``` of the searched group as an ```Int```
    * **Returns**
        - *async* (```Bool```) - Returns ```true``` if successful, ```false``` if errored or failed.
        
        
* ```func MyGes.leaveProjectGroup()```
    
    Can be used to leave a group in a specific project.

    * **Parameters**
        - ```_ projectRcId``` : The ```project_rc_id``` of the project as an ```Int```
        - ```_ projectId``` : The ```project_id``` of the project as an ```Int```
        - ```_ projectGroupId``` : The ```project_group_id``` of the searched group as an ```Int```
    * **Returns**
        - *async* (```Bool```) - Returns ```true``` if successful, ```false``` if errored or failed.
        
        
* ```func MyGes.getProfilePicLink()```
    
    Can be used to get the profile picture link of a student.

    * **Returns**
        - *async* (```String?```) - In case of success, link is returned as a ```String```, if errored or failed, ```nil``` is returned
        
        
## Installation

`MyGes` API wrapper is available using the [Swift Package Manager](https://swift.org/package-manager/):

Using Xcode 11, go to `File -> Swift Packages -> Add Package Dependency` and enter https://github.com/AdrienRoux/MyGes-Swift-Api

If you are using `Package.swift`, you can also add `MyGes` as a dependency easily.

```swift
let package = Package(
  name: "TestProject",
  dependencies: [
    .package(url: "https://github.com/AdrienRoux/MyGes-Swift-Api", from: "1.0.0")
  ],
  targets: [
    .target(name: "TestProject", dependencies: ["MyGes"])
  ]
)
```

## Requirements

- iOS 13.0+
- Xcode 11.0+

## Contributing

If you find a bug, or would like to suggest a new feature or enhancement, it'd be nice if you could [search the issue tracker](https://github.com/AdrienRoux/MyGes-Swift-Api/issues) first; while we don't mind duplicates, keeping issues unique helps us save time and considates effort. If you can't find your issue, feel free to [file a new one](https://github.com/AdrienRoux/MyGes-Swift-Api/issues/new).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
