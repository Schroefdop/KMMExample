package me.wouter.library


class Greeting {
    fun greeting(): String {
        return "Hello, ${Platform().platform}!"
    }
}