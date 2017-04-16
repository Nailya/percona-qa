#!/usr/bin/env bats
load test_helper


@test "run pmm-admin remove all mysql metrics" {
run sudo pmm-admin remove --all
echo "$output"
  [ "$status" -eq 0 ]
  echo  "${lines[0]}" |grep  "OK"
}

@test "run pmm-admin add mysql" {
run sudo pmm-admin add mysql
echo "$output"
  [ "$status" -eq 0 ]
  echo  "${lines[0]}" |grep  "OK"
}

@test "stop PMM server" {
run sudo docker stop pmm-server
echo "$output"
  [ "$status" -eq 0 ]
}

@test "run pmm-admin show-passwords with stopped PMM server" {
run sudo pmm-admin show-passwords
  [ "$status" -eq 0 ]
  echo  "$output" |grep  "HTTP basic auth"
  echo  "$output" |grep  "MySQL"
}

@test "run pmm-admin restart --all" {
run sudo pmm-admin restart --all
echo "$output"
  [ "$status" -eq 0 ]
  echo  "${lines[0]}" |grep  "OK, restarted "
}

@test "start PMM server" {
run sudo docker start pmm-server
echo "$output"
  [ "$status" -eq 0 ]
}

@test "wait while PMM server starts" {
run sleep 15
  [ "$status" -eq 0 ]
}

@test "check that all services are running" {
run sudo pmm-admin list
echo "$output"
  [ "$status" -eq 0 ]
  echo  "${lines[10]}" |grep  "YES"
}

@test "stop PMM server" {
run sudo docker stop pmm-server
echo "$output"
  [ "$status" -eq 0 ]
}

@test "run pmm-admin stop --all" {
run sudo pmm-admin stop --all
echo "$output"
  [ "$status" -eq 0 ]
  echo  "${lines[0]}" |grep  "OK, stop"
}

@test "start PMM server" {
run sudo docker start pmm-server
echo "$output"
  [ "$status" -eq 0 ]
}

@test "wait while PMM server starts" {
run sleep 15
  [ "$status" -eq 0 ]
}

@test "check that all services are not running" {
run sudo pmm-admin list
echo "$output"
  [ "$status" -eq 0 ]
  echo  "${lines[10]}" |grep  "NO"
}

@test "stop PMM server" {
run sudo docker stop pmm-server
echo "$output"
  [ "$status" -eq 0 ]
}

@test "run pmm-admin start --all" {
run sudo pmm-admin start --all
echo "$output"
  [ "$status" -eq 0 ]
  echo  "${lines[0]}" |grep  "OK, start"
}

@test "start PMM server" {
run sudo docker start pmm-server
echo "$output"
  [ "$status" -eq 0 ]
}

@test "wait while PMM server starts" {
run sleep 15
  [ "$status" -eq 0 ]
}

@test "check that all services are running" {
run sudo pmm-admin list
echo "$output"
  [ "$status" -eq 0 ]
  echo  "${lines[10]}" |grep  "YES"
}
