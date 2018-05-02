---
title: Searching for Dispensers
keywords: develop
tags: [develop]
sidebar: overview_sidebar
permalink: searching.html
summary: How to use the search resources and how the system finds matching dispensers
---


The API provides two search resources:

  * `/epsdispenser/byLocationAndTime` - used when matching a resource to a patient based on the patient's need and location
  * `/epsdispenser/byNameAndPostcode` - used to locate a specific dispenser which the patient may have named

## Searching by Location & Opening Hours ##

The most common operation will be to find a dispenser which can dispense a prescription to the patient within the timeframe dictated by the patient disposition. Patients disposition is allocated by NHS Pathways and include values like `Dx85	- Repeat prescription required within 2 hours`. Passing an integer number of hours to the API will ensure that all dispensers returned in results are open within at least a portion of that timeframe. Once open dispensers are identified the system orders by distance and returns the five nearest. If a maximum distance filter is included this is applied, otherwise the system will default to a maximum distance of 38km.

## Search Results ##

Searching by Location & Time results in an array of up to five epsdispenser resources. Only relevant opening hours are included in the these responses.

### Examples ###

```json
$ curl - u 'eps_example:3pstest''https://eps-dos.service.nhs.uk/epsdispenser/byLocationAndTime?postcode=N1C+4AL&timeframe=24'
[{
  "ods": "FJ679",
  "name": "Boots",
  "service_type": "eps_pharmacy",
  "address": {
    "line": ["Unit 2 Western Ticket  Hall", "Kings Cross London Underground", "London", "Middlesex"],
    "postcode": "N1C 4AL"
  },
  "patient_contact": {
    "tel": "0207 713 9519",
    "web_address": "http://www.boots.com/"
  },
  "prescriber_contact": {
    "tel": "0207 713 9519",
    "fax": "0208 713 6883"
  },
  "location": {
    "easting": 530111.0,
    "northing": 182950.0
  },
  "opening": {
    "open_247": false,
    "wed": [{
      "open": "07:30",
      "close": "21:30"
    }],
    "thu": [{
      "open": "07:30",
      "close": "21:30"
    }]
  },
  "distance": 0.0
}, {
  "ods": "FE513",
  "name": "Boots",
  "service_type": "eps_pharmacy",
  "address": {
    "line": ["Euston Rd", "", "London", "Middlesex"],
    "postcode": "N1C 4QL"
  },
  "patient_contact": {
    "tel": "0207 833 0216",
    "web_address": "http://www.boots.com/"
  },
  "prescriber_contact": {
    "tel": "",
    "fax": ""
  },
  "location": {
    "easting": 530076.0,
    "northing": 183055.0
  },
  "opening": {
    "open_247": false,
    "wed": [{
      "open": "07:00",
      "close": "23:59"
    }],
    "thu": [{
      "open": "07:00",
      "close": "23:59"
    }]
  }
}]
```

## Searching by Name ##

Patients may have a specific dispenser who they want a prescription to be sent to: searching by name allows full details of any dispenser to be selected. Complete opening hours are included in responses and so dispensers can be viewed even if currently closed. 

### Examples ###

```json
$ curl - u 'eps_test:3psexample' 'https://eps-dos.service.nhs.uk/epsdispenser/byNameAndPostcode?postcode=N1C+4AL&name=boots'
[{
  "ods": "FJ679",
  "name": "Boots",
  "service_type": "eps_pharmacy",
  "address": {
    "line": ["Unit 2 Western Ticket  Hall", "Kings Cross London Underground", "London", "Middlesex"],
    "postcode": "N1C 4AL"
  },
  "patient_contact": {
    "tel": "0207 713 9519",
    "web_address": "http://www.boots.com/"
  },
  "prescriber_contact": {
    "tel": "0207 713 9519",
    "fax": "0208 713 6883"
  },
  "location": {
    "easting": 530111.0,
    "northing": 182950.0
  },
  "opening": {
    "open_247": false,
    "bank_holiday": [{
      "open": "10:00",
      "close": "19:00"
    }],
    "mon": [{
      "open": "07:30",
      "close": "21:30"
    }],
    "tue": [{
      "open": "07:30",
      "close": "21:30"
    }],
    "wed": [{
      "open": "07:30",
      "close": "21:30"
    }],
    "thu": [{
      "open": "07:30",
      "close": "21:30"
    }],
    "fri": [{
      "open": "07:30",
      "close": "21:30"
    }],
    "sat": [{
      "open": "08:00",
      "close": "20:00"
    }],
    "sun": [{
      "open": "09:00",
      "close": "19:00"
    }],
    "specified_date": {
      "25-12-2017": [],
      "26-12-2017": []
    }
  },
  "distance": 0.0
}, {
  "ods": "FE513",
  "name": "Boots",
  "service_type": "eps_pharmacy",
  "address": {
    "line": ["Euston Rd", "", "London", "Middlesex"],
    "postcode": "N1C 4QL"
  },
  "patient_contact": {
    "tel": "0207 833 0216",
    "web_address": "http://www.boots.com/"
  },
  "prescriber_contact": {
    "tel": "",
    "fax": ""
  },
  "location": {
    "easting": 530076.0,
    "northing": 183055.0
  },
  "opening": {
    "open_247": false,
    "bank_holiday": [{
      "open": "09:00",
      "close": "21:00"
    }],
    "mon": [{
      "open": "07:00",
      "close": "23:59"
    }],
    "tue": [{
      "open": "07:00",
      "close": "23:59"
    }],
    "wed": [{
      "open": "07:00",
      "close": "23:59"
    }],
    "thu": [{
      "open": "07:00",
      "close": "23:59"
    }],
    "fri": [{
      "open": "07:00",
      "close": "23:59"
    }],
    "sat": [{
      "open": "08:00",
      "close": "23:59"
    }],
    "sun": [{
      "open": "09:00",
      "close": "21:00"
    }],
    "specified_date": {
      "25-12-2017": []
    }
  },
  "distance": 0.1
}, {
  "ods": "FFE92",
  "name": "Boots",
  "service_type": "eps_pharmacy",
  "address": {
    "line": ["Kings Cross Railway Station", "Kings Cross", "London", "Middlesex"],
    "postcode": "N1C 4AP"
  },
  "patient_contact": {
    "tel": "0207 278 5861",
    "web_address": "http://www.boots.com/en/Store-Locator/Boots-London-Kings-Cross-Station/"
  },
  "prescriber_contact": {
    "tel": "0207 278 5861",
    "fax": "0208 837 4191"
  },
  "location": {
    "easting": 530270.0,
    "northing": 183166.0
  },
  "opening": {
    "open_247": false,
    "bank_holiday": [{
      "open": "10:00",
      "close": "19:00"
    }],
    "mon": [{
      "open": "07:00",
      "close": "22:00"
    }],
    "tue": [{
      "open": "07:00",
      "close": "22:00"
    }],
    "wed": [{
      "open": "07:00",
      "close": "22:00"
    }],
    "thu": [{
      "open": "07:00",
      "close": "22:00"
    }],
    "fri": [{
      "open": "07:00",
      "close": "22:00"
    }],
    "sat": [{
      "open": "07:00",
      "close": "22:00"
    }],
    "sun": [{
      "open": "09:00",
      "close": "21:00"
    }],
    "specified_date": {
      "25-12-2017": [],
      "26-12-2017": [],
      "01-01-2018": [{
        "open": "09:00",
        "close": "19:00"
      }]
    }
  },
  "distance": 0.2
}]
```
