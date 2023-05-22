import React from "react";
import { Link } from "react-router-dom";

export default () => (
  <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center">
    <div className="jumbotron jumbotron-fluid bg-transparent">
      <div className="container secondary-color">
        <h1 className="display-4">Invoice Management</h1>
        <p className="lead">
          Management of Invoices of Borrowers. Invoices can be created, rejected, approved, purchased and closed.
          <br></br>
          <br></br>
          Here are the basics -
          <br></br>
          i) Only created invoices can be approved or rejected.
          <br></br>
          ii) Only approved invoices can be purchased.
          <br></br>
          iii) Only purchased invoices can be closed.
        </p>
        <hr className="my-4" />
        <span>
          <Link
            to="/invoice"
            className="btn btn-lg custom-button"
            role="button"
          >
            Create Invoice
          </Link>
          <Link
            to="/invoices"
            className="btn btn-lg custom-button"
            role="button"
          >
            View Invoices
          </Link>
        </span>
      </div>
    </div>
  </div>
);