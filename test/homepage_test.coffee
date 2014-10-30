process.env.NODE_ENV = 'test'
require('mocha')
chai = require('chai')
Browser = require('zombie')
assert = require('assert')
expect = chai.expect
server = require('../app')
fs = require('fs')

describe 'home page', ->
	browser = null

	before ->
		server.listen(3000)
		browser = new Browser({ site: 'http://localhost:3000' })
		fs.writeFile('code/test_file.txt', 'This is your first file!')
		browser.visit '/'
		

	after ->
		fs.unlink('code/test_file.txt')

	it 'should show a welcome message', ->
		expect(browser.text('h1')).to.equal('Welcome to Annas ide')

	it 'can display my layout', ->
		assert(browser.querySelector('.files'))

	it 'should display available files', ->
		expect(browser.text('.files a:first-child')).to.equal('test_file.txt')