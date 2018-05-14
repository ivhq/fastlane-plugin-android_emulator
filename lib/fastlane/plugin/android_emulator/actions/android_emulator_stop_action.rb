require 'fastlane/action'
require_relative '../helper/android_emulator_helper'

module Fastlane
  module Actions
    module SharedValues
      ANDROID_SDK_DIR = :ANDROID_SDK_DIR
    end

    class AndroidEmulatorStopAction < Action
      def self.run(params)
        sdk_dir = params[:sdk_dir]
        adb = "#{sdk_dir}/platform-tools/adb"

        UI.message("Stopping emulator")
        system("#{adb} emu kill > /dev/null 2>&1 &")
        sleep(2)
      end

      def self.description
        "Stops a running Android Emulator"
      end

      def self.details
        "Great for Screengrab"
      end

      def self.example_code
        [
          'android_emulator_stop(
            sdk_dir: "PATH_TO_SDK"
          )'
        ]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :sdk_dir,
                                       env_name: "ANDROID_SDK_DIR",
                                       description: "Path to the Android SDK DIR",
                                       default_value: Actions.lane_context[SharedValues::ANDROID_SDK_DIR],
                                       optional: false,
                                       verify_block: proc do |value|
                                         UI.user_error!("No ANDROID_SDK_DIR given, pass using `sdk_dir: 'sdk_dir'`") unless value and !value.empty?
                                       end)
        ]
      end

      def self.authors
        ["Michael Ruhl"]
      end

      def self.is_supported?(platform)
        platform == :android
      end
    end
  end
end
