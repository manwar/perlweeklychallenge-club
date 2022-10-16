#!/usr/bin/env node

'use strict';

function makeover( ...array ) {
	return array.map(string => string.concat(': ', string.normalize('NFKD').slice(0, -1)));
}

makeover( 'ÃÊÍÒÙ', 'âÊíÒÙ' ).forEach(ascii => console.log(ascii));
