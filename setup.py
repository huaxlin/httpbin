import os
import io
from pkg_resources import parse_requirements
from pathlib import Path
from setuptools import setup, find_packages


with open(os.path.join(os.path.realpath(os.path.dirname(__file__)), 'httpbin', 'VERSION')) as version_file:
    version = version_file.read().strip()

def parse_requirements_file(f):
    return [str(req) for req in parse_requirements(Path(f).read_text())]

install_requires = parse_requirements_file('requirements.txt')


setup(
    name="httpbin",
    version=version,
    description="HTTP Request and Response Service",
    long_description="A simple HTTP Request & Response Service, written in Python + Flask.",

    # The project URL.
    url='https://github.com/requests/httpbin',

    # Author details
    author='Kenneth Reitz',
    author_email='me@kennethreitz.org',

    # Choose your license
    license='MIT',

    classifiers=[
         'Development Status :: 5 - Production/Stable',
         'Intended Audience :: Developers',
         'Natural Language :: English',
         'License :: OSI Approved :: MIT License',
         'Programming Language :: Python',
    ],
    test_suite="test_httpbin",
    packages=find_packages(),
    include_package_data = True, # include files listed in MANIFEST.in
    install_requires=install_requires,
)
