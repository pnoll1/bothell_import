#!/usr/bin/env python3
# -*- coding: utf-8 -*-
# Data from observation and Appendix B (p271) of 
# http://www.census.gov/geo/www/tiger/tiger2006se/TGR06SE.pdf
from osgeo import ogr

def expandName(geoname):
    '''
    expands known abbreviations
    '''
    if not geoname:
        return

    newName = ''
    
    fullName = {
        'AL':'Alley',
        'ALY':'Alley',
        'ARC':'Arcade',
        'AVE':'Avenue',
        'BLF':'Bluff',
        'BLVD':'Boulevard',
        'BR':'Bridge',
        'BRG':'Bridge',
        'BYP':'Bypass',
        'CIR':'Circle',
        'CRES':'Crescent',
        'CSWY':'Crossway',
        'CT':'Court',
        'CTR':'Center',
        'CV':'Cove',
        'DR':'Drive',
        'ET':'ET',
        'EXPY':'Expressway',
        'EXPWY':'Expressway',
        'FMRD':'Farm to Market Road',
        'FWY':'Freeway',
        'GRD':'Grade',
        'HBR':'Harbor',
        'HOLW':'Hollow',
        'HWY':'Highway',
        'LN':'Lane',
        'LNDG':'Landing',
        'MAL':'Mall',
        'MTWY':'Motorway',
        'OVPS':'Overpass',
        'PKY':'Parkway',
        'PKWY':'Parkway',
        'PL':'Place',
        'PLZ':'Plaza',
        'RD':'Road',
        'RDG':'Ridge',
        'RMRD':'Ranch to Market Road',
        'RTE':'Route',
        'SKWY':'Skyway',
        'SQ':'Square',
        'ST':'Street',
        'TER':'Terrace',
        'TFWY':'Trafficway',
        'THFR':'Thoroughfare',
        'THWY':'Thruway',
        'TPKE':'Turnpike',
        'TRCE':'Trace',
        'TRL' :'Trail',
        'TUNL':'Tunnel',
        'UNP':'Underpass',
        'VIS':'Vista',
        'WKWY':'Walkway',
        'XING':'Crossing',
        ### NOT EXPANDED
        'WAY':'Way',
        'WALK':'Walk',
        'LOOP':'Loop',
        'OVAL':'Oval',
        'RAMP':'Ramp',
        'ROW':'Row',
        'RUN':'Run',
        'PASS':'Pass',
        'SPUR':'Spur',
        'PATH':'Path',
        'PIKE':'Pike',
        'RUE':'Rue',
        'MALL':'Mall',
        'N':'North',
        'S':'South',
        'E':'East',
        'W':'West',
        'NE':'Northeast',
        'NW':'Northwest',
        'SE':'Southeast',
        'SW':'Southwest'}

    newName = fullName.get(geoname)
    return newName.strip()

'''def filterFeature(ogrfeature, fieldNames, reproject):
    features_drop = ('GISID', 'Status', 'Unit_Type', 'Unit_Bldg', 'Bldg_Name', 
                     'Addr_FR', 'County', 'PIN', 'Full_Addre', 'UpDt', 'UpDtBy', 
                     'Jurisdicti', 'LucityAuto', 'InLucity', 'LucitySync', 
                     'last_edite', 'GenNote')
    index = ogrfeature.GetFieldIndex('AddressLab')
    if index >= 0:
        AddressLab = ogrfeature.GetField(index)
        if not AddressLab:
            return None

    return ogrfeature
'''
def filterTags(attrs):
    '''
    grab data, put into osm format and tag using osm tags
    '''
    if not attrs: 
        return
    tags = {}
    pre_dir = ''
    suf = ''
    post_dir = ''
    addr = ''
    housenumber = ''
    
    #convert housenumber
    if 'Addr_Num' in attrs:
        housenumber = attrs['Addr_Num']
        tags['addr:housenumber'] = housenumber

    #construct address
    if 'PreDir' in attrs and attrs['PreDir'] != '':
        pre_dir = expandName(attrs['PreDir'])

    if 'Street_Typ' in attrs and attrs['PreDir'] != '':
        suf = expandName(attrs['Street_Typ'])

    if 'PostDir' in attrs and attrs['PostDir'] != '':
        post_dir = expandName(attrs['PostDir'])

    if 'Street' in attrs:
        if attrs['Street'].isalpha():
            street = attrs['Street'].title()
        else:
            street = attrs['Street'].lower()

    if pre_dir:
        addr = pre_dir + ' ' + street
    else:
        addr = street
    if suf:
        addr = addr + " " + suf
    if post_dir:
        addr = addr + ' ' + post_dir
    tags['addr:street'] = addr
    
    if 'PostalCity' in attrs:
        tags['addr:city'] = attrs['PostalCity']

    if 'Unit' in attrs and attrs['Unit'] != '':
        tags['addr:unit'] = attrs['Unit']
    if 'State' in attrs:
        tags['addr:state'] = attrs['State']
    if 'Zip' in attrs:
        tags['addr:postcode'] = attrs['Zip']

    tags['source'] = 'Bothell WA GIS'

    return tags
