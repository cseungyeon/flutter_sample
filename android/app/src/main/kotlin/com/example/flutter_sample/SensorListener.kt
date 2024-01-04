package com.example.flutter_sample

import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import io.flutter.plugin.common.EventChannel

class SensorListener(private val sensorManager: SensorManager) :
    EventChannel.StreamHandler, SensorEventListener {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink?) {
        this.eventSink = eventSink
        registerIfActive()
    }

    override fun onCancel(arguments: Any?) {
        unregisterIfActive()
        eventSink = null
    }

    override fun onSensorChanged(event: SensorEvent) {
        eventSink?.success(event.values)
    }

    override fun onAccuracyChanged(sensor: Sensor?, accuracy: Int) {
        if (accuracy == SensorManager.SENSOR_STATUS_ACCURACY_LOW)
            eventSink?.error("SENSOR", "Low accuracy detected", null)
    }

    fun registerIfActive() {
        if (eventSink == null) return
        sensorManager.registerListener(
            this,
            sensorManager.getDefaultSensor(Sensor.TYPE_GYROSCOPE),
            SensorManager.SENSOR_DELAY_NORMAL
        )
    }

    fun unregisterIfActive() {
        if (eventSink == null) return
        sensorManager.unregisterListener(this)
    }
}