module OmniShip
  module Landmark
    module Track
      class Shipment
        attr_accessor :root

        # Initialize a new Shipment.
        #
        #
        # Returns the newly initialized Shipment.
        def initialize(root)
          @root = root
        end

        def root
          @root
        end

        # The list of packages in this shipment.
        #
        # Returns an array of Package objects.
        def packages
          @root.xpath("TrackResponse/Result/Packages/Package").map do |package|
            Package.new(package)
          end
        end

        # The scheduled delivery date. If a specific time of day is available
        # then it will be set, otherwise the time will be set to noon. If no
        # delivery date is available, the result will be nil.
        #
        # Returns the Time of the delivery, or nil if none is available.
        def scheduled_delivery
         packages.first.scheduled_delivery
        end

        # The scheduled delivery date as a String in YYYYMMDD format.
        #
        # Returns the String delivery date or nil if none is available.
        def scheduled_delivery_date
         packages.first.scheduled_delivery_date
        end

        # The scheduled delivery time as a String in HHMMSS format.
        #
        # Returns the String delivery time or nil if none is available.
        def scheduled_delivery_time
          nil
        end

        # Returns a Hash representation of this object.
        def to_hash
          {
            "ScheduledDelivery" => scheduled_delivery.to_i,
            "Packages" => packages.map { |x| x.to_hash }
          }
        end
      end
    end
  end
end
