from django.contrib.staticfiles.testing import StaticLiveServerTestCase
from selenium import webdriver


class SeleniumTestCase(StaticLiveServerTestCase):

    @classmethod
    def setUpClass(self):
        super(SeleniumTestCase, self).setUpClass()
        self.browser = webdriver.Firefox()

    @classmethod
    def tearDownClass(self):
        self.browser.quit()
        super(SeleniumTestCase, self).tearDownClass()

    def test_hello(self):
        self.browser.get(self.live_server_url)
        self.assertIn('hello, world', self.browser.page_source)
