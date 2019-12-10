import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
    var centerCoordinate: CLLocationCoordinate2D
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let placemark = MKPlacemark(coordinate: centerCoordinate)
        view.addAnnotation(placemark)
        
        if CLLocationManager.locationServicesEnabled() {
            let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
            let region = MKCoordinateRegion(center: centerCoordinate, span: span)
            view.setRegion(region, animated: true)
        }
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            parent.centerCoordinate = mapView.centerCoordinate
        }
    }
}
