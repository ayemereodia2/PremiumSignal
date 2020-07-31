import 'dart:io';

String fixture(String nameOfFile) => File('test/sampleJson/$nameOfFile').readAsStringSync();

String unverified(String nameOfFile) => File('test/sampleJson/$nameOfFile').readAsStringSync();