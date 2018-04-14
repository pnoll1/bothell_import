"""
Translation rules for Bothell Buildings
Copyright 2018 Clifford Snow
"""

def filterTags(attrs):
    if not attrs: 
        return

    tags = {}
    tags['building'] = 'yes'
    if 'ADDR_NUM' in attrs and attrs['ADDR_NUM'] != '':
        tags['addr:housenumber'] = attrs['ADDR_NUM']
    if 'UNIT' in attrs and attrs['UNIT'] != '':
        tags['addr:unit'] = attrs['UNIT']
    if 'STREETNAME' in attrs and attrs['STREETNAME'] != '':
        tags['addr:street'] = attrs['STREETNAME']
    if 'CITY' in attrs and attrs['CITY'] != '':
        tags['addr:city'] = attrs['CITY']
    if 'ZIP' in attrs and attrs['ZIP'] != '':
        tags['addr:postcode'] = attrs['ZIP']
    if 'BLDG_TYPE' in attrs and attrs['BLDG_TYPE'] != '':
        if attrs['BLDG_TYPE'] == 'Accessory':
            tags['building'] = 'semidetached_house'

        if attrs['BLDG_TYPE'] == 'Church':
            tags['building'] = 'church'

        if attrs['BLDG_TYPE'] == 'Commercial':
            tags['building'] = 'commercial'

        if attrs['BLDG_TYPE'] == 'Local Government':
            tags['building'] = 'public'

        if attrs['BLDG_TYPE'] == 'Manufactured Home':
            tags['building'] = 'manufactured'

        if attrs['BLDG_TYPE'] == 'Mobile Home':
            tags['building'] = 'static_caravan'

        if attrs['BLDG_TYPE'] == 'Multi Family' and attrs['NO_ADDR'] < 4:
            tags['building'] = 'residential'

        if attrs['BLDG_TYPE'] == 'Multi Family' and attrs['NO_ADDR'] > 3:
            tags['building'] = 'apartments'

        if attrs['BLDG_TYPE'] == 'Other Public Facility':
            tags['building'] = 'public'

        if attrs['BLDG_TYPE'] == 'Private School':
            tags['building'] = 'school'
    if 'FLOORS' in attrs and attrs['FLOORS'] != '':
        tags['building:levels'] = attrs['FLOORS']

    if 'NAME' in attrs and attrs['NAME'] != '':
        tags['name'] = attrs['NAME']

    if 'YRBUILT' in attrs and attrs['YRBUILT'] > 1800:
        tags['start_date'] = attrs['YRBUILT']
        
    return tags
