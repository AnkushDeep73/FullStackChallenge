import React from "react";
import { Link } from "react-router-dom";

export default () => (
  <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center">
    <div className="jumbotron jumbotron-fluid bg-transparent">
      <div className="container secondary-color">
        <h1 className="display-4">Lender Management Tool</h1>
        <p className="lead">
          Lender Management tool for Borrowers and their Invoices.
          <br></br>
          Using this tool, Borrowers can be created and their Invoices can be created, rejected, approved, purchased and closed.
          <br></br>
          <br></br>
          Here are the basics -
          <br></br>
          i) A Borrower can have 0 or more Invoices.
          <br></br>
          ii) Only created Invoices can be approved or rejected.
          <br></br>
          iii) Only approved Invoices can be purchased.
          <br></br>
          iv) Only purchased Invoices can be closed.
        </p>
        <hr className="my-4" />
        <span>
          <Link
            to="/borrower"
            className="btn btn-lg custom-button"
            role="button"
          >
            Create Borrower
          </Link>
          <Link
            to="/borrowers"
            className="btn btn-lg custom-button"
            role="button"
          >
            View Borrowers
          </Link>
        </span>
      </div>
    </div>
  </div>
);