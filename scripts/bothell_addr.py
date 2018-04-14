"""
Translation rules for Bothell Buildings
Copyright 2018 Clifford Snow
"""

def filterTags(attrs):
    if not attrs: 
        return

    tags = {}
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
        
    return tags
