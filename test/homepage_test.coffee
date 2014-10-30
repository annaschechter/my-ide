process.env.NODE_ENV = 'test'
require('mocha')
chai = require('chai')
Browser = require('zombie')
assert = require('assert')
expect = chai.expect
server = require('../app')
fs = require('fs')

describe 'Annas ide', ->

	browser = null

	before ->
		server.listen(3000)
		browser = new Browser({ site: 'http://localhost:3000' })
		fs.writeFile('code/test_file.txt', 'This is your first file!')
		browser.visit '/'
		
	# after ->
	# 	fs.unlink('code/test_file.txt')


	describe 'home page', ->

		it 'should show a welcome message', ->
			expect(browser.text('h1')).to.equal('Welcome to Annas ide')

		it 'can display my layout', ->
			assert(browser.querySelector('.files'))

		it 'should display available files', ->
			expect(browser.text('.files a:first-child')).to.equal('test_file.txt')

		it 'takes you to an edit page when clicked on', ->
			browser.clickLink 'test_file.txt', ->
				expect(browser.location.pathname).to.equal('/edit?file=test_file.txt')

	describe 'editor page', ->

		it 'should have a text area field when loaded', ->
			console.log browser.html()
			# expect(browser.text('textarea')).to.equal("")
			expect(browser.text('#file_content')).to.equal("")




