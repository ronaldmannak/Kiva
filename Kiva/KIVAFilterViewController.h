//
//  KIVAFilterViewController.h
//  Kiva
//
//  Created by Ronald Mannak on 6/14/14.
//  Copyright (c) 2014 Ronald Mannak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KIVAFilterViewController : UIViewController

@end

/*
 Filter based on Leonard Verhoef's train ticket machine: http://vimeo.com/58854058
 
    Default filter settings:
        Conflict Zones
        Vulnerable Groups
        Underbanked Areas
        Green
        Youth
        Start-ups
        Inspiring Stories
        Islamic Finance
        Rural Communities
 
    level 1: Region
        All (selected by default)
        North America
        Central America
        South America
        Africa
        Middle East
        Eastern Europe
        Asia
        Oceania

    Level 1a: Countries
        case North America:
            All
            Dominican Republic 7
            Haiti 2
            Mexico 6
            United States 22
        case Central America
            All
            Costa Rica 32
            El Salvador 809
            Guatemala 53
            Honduras 403
            Nicaragua 331
        case South America:
            All
            Bolivia 99
            Colombia 286
            Ecuador 82
            Paraguay 65
            Peru 259
            Suriname 12
        case Africa:
            All
            Benin 82
            Burkina Faso 5
            Burundi 10
            Cameroon 10
            Ghana 10
            Kenya 205
            Liberia 19
            Mali 167
            Rwanda 51
            Senegal 60
            Sierra Leone 116
            Tanzania 46
            Togo 37
            Uganda 183
            Zambia 4
            Zimbabwe 90
        case Middle East:
            All
            Iraq 39
            Jordan 40
            Lebanon 57
            Palestine 6
            Turkey 1
            Yemen 96
        case Eastern Europe:
            All
            Albania 15
            Armenia 99
            Georgia 10
            Kosovo 41
            Ukraine 13
        case Asia:
            Azerbaijan 41
            Cambodia 252
            India 40
            Indonesia 7
            Kyrgyzstan 30
            Mongolia 37
            Pakistan 246
            Philippines 1,294
            Tajikistan 168
            Vietnam 39
        case Oceania:
            All
            Samoa 37
            Timor-Leste 7
 
    Level 2: Gender
        Any
        Female
        Male
 
    Level 3:Sector
        Any
        Agriculture
        Arts
        Clothing
        Construction
        Education
        Entertainment
        Food
        Health
        Housing
        Manufacturing
        Personal Use
        Retail
        Services
        Transportation
        Wholesale
 
    Level 4: Groups or individual
        Groups
        Individuals
 
    Level 5: Attributes
        Any
        Green
        Higher Education
        Islamic Finance
        Youth
        Start-up
        Water and Sanitation
        Vulnerable Groups
        Fair Trade
        Rural Communities
        Mobile Technologies
        Underfunded Areas
        Conflict Zones
        Job Creation
        Growing Businesses
        Disaster Recovery
 
    Level 6: Matched Loans
        Matched Loans
 
 */
