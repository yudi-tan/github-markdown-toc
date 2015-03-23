#!/usr/bin/env bats

load test_helper


@test "TOC for local README.md" {
    run $BATS_TEST_DIRNAME/../gh-md-toc README.md
    assert_success

    assert_equal "${lines[0]}"  "Table of Contents"
    assert_equal "${lines[1]}"  "================="
    assert_equal "${lines[2]}"  "  * [gh-md-toc](#gh-md-toc)"
    assert_equal "${lines[3]}"  "  * [Table of contents](#table-of-contents)"
    assert_equal "${lines[4]}"  "  * [Installation](#installation)"
    assert_equal "${lines[5]}"  "  * [Usage](#usage)"
    assert_equal "${lines[6]}"  "    * [STDIN](#stdin)"
    assert_equal "${lines[7]}"  "    * [Local files](#local-files)"
    assert_equal "${lines[8]}"  "    * [Remote files](#remote-files)"
    assert_equal "${lines[9]}"  "    * [Combo](#combo)"
    assert_equal "${lines[10]}" "  * [Dependency](#dependency)"
    assert_equal "${lines[11]}" "Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)"

}

@test "TOC for remote README.md" {
    run $BATS_TEST_DIRNAME/../gh-md-toc https://github.com/ekalinin/sitemap.js/blob/master/README.md
    assert_success

    assert_equal "${lines[0]}"  "Table of Contents"
    assert_equal "${lines[1]}"  "================="
    assert_equal "${lines[2]}"  "  * [sitemap.js](#sitemapjs)"
    assert_equal "${lines[3]}"  "    * [Installation](#installation)"
    assert_equal "${lines[4]}"  "    * [Usage](#usage)"
    assert_equal "${lines[5]}"  "    * [License](#license)"
    assert_equal "${lines[6]}"  "Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)"
}

@test "TOC for mixed README.md (remote/local)" {
    run $BATS_TEST_DIRNAME/../gh-md-toc \
        README.md \
        https://github.com/ekalinin/sitemap.js/blob/master/README.md
    assert_success

    assert_equal "${lines[0]}"   "  * [gh-md-toc](README.md#gh-md-toc)"
    assert_equal "${lines[1]}"   "  * [Table of contents](README.md#table-of-contents)"
    assert_equal "${lines[2]}"   "  * [Installation](README.md#installation)"
    assert_equal "${lines[3]}"   "  * [Usage](README.md#usage)"
    assert_equal "${lines[4]}"   "    * [STDIN](README.md#stdin)"
    assert_equal "${lines[5]}"   "    * [Local files](README.md#local-files)"
    assert_equal "${lines[6]}"   "    * [Remote files](README.md#remote-files)"
    assert_equal "${lines[7]}"   "    * [Combo](README.md#combo)"
    assert_equal "${lines[8]}"   "  * [Dependency](README.md#dependency)"
    assert_equal "${lines[9]}"   "  * [sitemap.js](https://github.com/ekalinin/sitemap.js/blob/master/README.md#sitemapjs)"
    assert_equal "${lines[10]}"  "    * [Installation](https://github.com/ekalinin/sitemap.js/blob/master/README.md#installation)"
    assert_equal "${lines[11]}"  "    * [Usage](https://github.com/ekalinin/sitemap.js/blob/master/README.md#usage)"
    assert_equal "${lines[12]}"  "    * [License](https://github.com/ekalinin/sitemap.js/blob/master/README.md#license)"
    assert_equal "${lines[13]}"  "Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc)"
}

@test "TOC for markdown from stdin" {
    cat README.md | {
        run $BATS_TEST_DIRNAME/../gh-md-toc -
        assert_success
        assert_equal "${lines[0]}"  "  * [gh-md-toc](#gh-md-toc)"
        assert_equal "${lines[1]}"  "  * [Table of contents](#table-of-contents)"
        assert_equal "${lines[2]}"  "  * [Installation](#installation)"
        assert_equal "${lines[3]}"  "  * [Usage](#usage)"
        assert_equal "${lines[4]}"  "    * [STDIN](#stdin)"
        assert_equal "${lines[5]}"  "    * [Local files](#local-files)"
        assert_equal "${lines[6]}"  "    * [Remote files](#remote-files)"
        assert_equal "${lines[7]}"  "    * [Combo](#combo)"
        assert_equal "${lines[8]}"  "  * [Dependency](#dependency)"
    }
}